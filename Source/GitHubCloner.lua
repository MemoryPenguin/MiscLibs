local BaseApiUrl = "https://api.github.com/"
local BaseRawUrl = "https://raw.githubusercontent.com/"
local DefaultTag = "master"

local HttpService = game:GetService("HttpService")

local HttpBroker do
	if game.ReplicatedStorage:FindFirstChild("Load") then
		local Load = require(game.ReplicatedStorage.Load)
		HttpBroker = Load("HttpBroker")
	elseif game.ReplicatedStorage:FindFirstChild("HttpBroker") then
		HttpBroker = require(game.ReplicatedStorage.HttpBroker)
	elseif script:FindFirstChild("HttpBroker") then
		HttpBroker = require(script.HttpBroker)
	else
		error("[GitHubCloner]: HttpBroker module is not available.")
	end
end

local broker = HttpBroker.new(200)

local GitHubCloner = {}

function GitHubCloner.Clone(user, repository, tag)
	tag = tag or DefaultTag
	local files = {}

	local success, treeListingJson = broker:Get(("%srepos/%s/%s/git/trees/%s?recursive=1"):format(BaseApiUrl, user, repository, tag))
	if not success then
		error("[GitHubCloner]: Could not retrieve file tree for user "..user.."'s repository "..repository.."@"..tag..": "..treeListingJson)
	end

	local treeListing = HttpService:JSONDecode(treeListingJson)
	if treeListing.truncated then
		warn("[GitHubCloner]: Truncated tree received for user "..user.."'s repository "..repository.."@"..tag.."; not all files can be retrieved.")
	end

	for _, entry in ipairs(treeListing.tree) do
		if entry.type == "blob" then
			local url = ("%s%s/%s/%s/%s"):format(BaseRawUrl, user, repository, tag, entry.path)
			local success, contents = broker:Get(url)
			
			if not success then
				error("[GitHubCloner]: Could not get file at "..url..": "..contents)
			end
			
			table.insert(files, {
				Path = entry.path;
				Content = contents;
				Sha = entry.sha;
			})
		end
	end

	return files
end

return GitHubCloner
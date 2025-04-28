local command = [[
  aws sts assume-role \
    --role-arn arn:aws:iam::917060388293:role/PierreNeoVimAvanteBedrockRole \
    --role-session-name MySession \
    --region eu-west-3 \
    --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
    --output text \
    | awk '{print $1","$2",eu-west-3,"$3}'
]]

local handle = io.popen(command)
if handle == nil then
  vim.notify("Failed to run AWS command", vim.log.levels.ERROR)
  return
end

local result = handle:read("*a")
handle:close()

result = result:gsub("%s+", "")
if result == nil or result == "" then
  vim.notify("Failed to retrieve BEDROCK_KEYS", vim.log.levels.ERROR)
  return
end

vim.fn.setenv("BEDROCK_KEYS", result)

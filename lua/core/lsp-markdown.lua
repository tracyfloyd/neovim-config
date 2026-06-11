-- Cleans up noisy LSP markdown (cssls, somesass_ls, etc.) before display:
--   * decode common HTML entities (&lt; &gt; &amp; &quot; &#39;)
--   * unescape characters that aren't markdown-special (\- \. \: \/ etc.)
--   * drop base64 data: image links and raw <img> tags (terminal can't render)
--   * collapse runs of 3+ newlines down to a single blank line
local M = {}

function M.clean(text)
  if type(text) ~= 'string' then return text end
  return text
    :gsub('&lt;', '<')
    :gsub('&gt;', '>')
    :gsub('&amp;', '&')
    :gsub('&quot;', '"')
    :gsub('&#39;', "'")
    :gsub('\\([%-%.%:/+=!%?,;~^%[%]%(%)])', '%1')
    :gsub('!%[[^%]]*%]%(data:[^%)]*%)', '')
    :gsub('<img[^>]*>', '')
    :gsub('\n\n\n+', '\n\n')
end

return M

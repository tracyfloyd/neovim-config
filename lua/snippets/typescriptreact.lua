local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require('luasnip.extras')
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

return {
  -- react use state
  s('rus', {
    t('const [ '),
    i(1),
    t('  , set'),
    i(2),
    t(''),
    rep(1),
    t(' ] = useState<'),
    i(3),
    t('>('),
    i(4),
    t(')'),
  }),

  -- react use effect
  s('ruf', {
    t('useEffect(() => {'),
    i(1),
    t('},['),
    i(2),
    t('])'),
  }),

  -- react functional component
  s('rfc', fmt([[
const {} = ({}) => {{
  return (
    <div>
      {}
    </div>
  );
}};

export default {};
]], {
    i(1, 'ComponentName'),
    i(2),
    i(3),
    rep(1),
  })),
}

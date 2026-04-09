-- Callout filter: handles ::: {.tip} divs and differentiates Tip / Trap /
-- Wut by inspecting the bold label on the first line of the content. Each
-- variant gets its own icon image, placed at the top-left of the callout
-- box. The path ../images/<kind>.png works for both LaTeX (from the book
-- dir, pointing at the top-level images/) and HTML (from a Jekyll chapter
-- page at /<book>/chNN.html, pointing at /images/ under docs/).

local tcb = "colback=black!5, colframe=black!20, " ..
  "boxrule=0.4pt, arc=2pt, left=5pt, right=5pt, " ..
  "top=4pt, bottom=4pt, fontupper=\\small"

local html_style = "background-color: #f5f5f5; border: 1px solid #ccc; " ..
  "border-radius: 4px; padding: 12px 16px; margin: 1em 0; font-size: 0.95em;"

-- Map the bold label text at the start of a callout to its icon basename.
local function callout_kind(el)
  local first = el.content[1]
  if not first or first.t ~= "Para" then return nil end
  local first_inline = first.content[1]
  if not first_inline or first_inline.t ~= "Strong" then return nil end
  local label = pandoc.utils.stringify(first_inline)
  if label == "Tip:"  then return "tip"  end
  if label == "Trap:" then return "trap" end
  if label == "Wut:"  then return "wut"  end
  return nil
end

function Div(el)
  if not el.classes:includes("tip") then return nil end

  local kind = callout_kind(el)
  local fmt = FORMAT

  if fmt:match("latex") then
    local blocks = pandoc.List({})
    blocks:insert(pandoc.RawBlock("latex",
      "\\begin{tcolorbox}[" .. tcb .. "]"))
    if kind and el.content[1] and el.content[1].t == "Para" then
      el.content[1].content:insert(1, pandoc.RawInline("latex",
        "\\raisebox{-0.35\\height}{\\includegraphics[height=2em]{../images/"
        .. kind .. ".png}}\\hspace{0.5em}"))
    end
    for _, cb in ipairs(el.content) do
      blocks:insert(cb)
    end
    blocks:insert(pandoc.RawBlock("latex", "\\end{tcolorbox}"))
    return blocks

  elseif fmt:match("html") then
    local blocks = pandoc.List({})
    blocks:insert(pandoc.RawBlock("html",
      '<div style="' .. html_style .. '">'))
    if kind and el.content[1] and el.content[1].t == "Para" then
      el.content[1].content:insert(1, pandoc.RawInline("html",
        '<img src="../images/' .. kind .. '.png" ' ..
        'style="height:1.5em;vertical-align:-0.3em;margin-right:0.4em;">'))
    end
    for _, cb in ipairs(el.content) do
      blocks:insert(cb)
    end
    blocks:insert(pandoc.RawBlock("html", '</div>'))
    return blocks
  end
end

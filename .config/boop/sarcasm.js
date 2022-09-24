/**
  {
    "api": 1,
    "name": "Sarcasm Text",
    "description": "TrAnSlAtEs To SaRcAsM",
    "author": "Tynor",
    "icon": "ellipsis.message",
    "tags": "sarcasm"
  }
**/

function main(state) {
  const chars = [];
  let i = 0;
  for (const c of state.text) {
    if (/[a-zA-Z]/.test(c)) {
      if (i % 2 === 0) {
        chars.push(c.toUpperCase());
      } else {
        chars.push(c.toLowerCase());
      }
      i++;
    } else {
      chars.push(c);
    }
  }
  state.text = chars.join("");
}

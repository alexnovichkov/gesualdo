.pragma library

function removeAmpersands(match, p1, p2, p3) {
    return p1.concat(p2, p3)
}

function replaceAmpersands(text, replaceFunction) {
    return text.replace(/([^&]*)&(.)([^&]*)/g, replaceFunction)
}

function stylizeMnemonics(text) {
    return replaceAmpersands(text, underlineAmpersands)
}

function removeMnemonics(text) {
    return replaceAmpersands(text, removeAmpersands)
}

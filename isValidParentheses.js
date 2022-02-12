const isValidParentheses = str => {
  const stack = []
  
  for (const char of str) {
    if (char === '(') stack.push(char);
    if (char === ')') {
      if (stack[0] === undefined) {
        return false
      } else {
        stack.pop()
      }
    }
  }
  return stack.length === 0 ? true : false
}

//test
//true cases
console.log(isValidParentheses(''))
console.log(isValidParentheses('(4 + 5) + (5 - 1)'))
console.log(isValidParentheses('(4 + 5) * 6'))
console.log(isValidParentheses('()(((((())))))()()'))
//false cases
console.log(isValidParentheses(')))'))
console.log(isValidParentheses('((((((('))
/**
 * @type {import('prettier').Config}
 */
const prettierConfig = {
  singleQuote: true,
  arrowParens: 'always',
  trailingComma: 'all',
  printWidth: 100,
  semi: true,
};

const config = {
  ...prettierConfig,
};

export default config;

export const Sleep = ms => new Promise(
  resolve => setTimeout(resolve, ms)
);
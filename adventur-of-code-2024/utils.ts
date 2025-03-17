import { readFile } from "node:fs/promises";

export async function read(name) {
  return await readFile(`./${name}`, { encoding: 'utf8' });
}

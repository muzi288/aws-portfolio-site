import { readFile, stat } from 'node:fs/promises';
import { resolve, dirname, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '../site');
const html = await readFile(resolve(root, 'index.html'), 'utf8');
const errors = [];
const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map(match => match[1]);
if (ids.length !== new Set(ids).size) errors.push('Duplicate HTML IDs');
if ([...html.matchAll(/<h1\b/g)].length !== 1) errors.push('Expected one page h1');
if (!/<html\s+lang="en"/.test(html)) errors.push('Missing document language');
if (!/<meta\s+name="description"\s+content="[^"]+"/.test(html)) errors.push('Missing page description');
for (const [, reference] of html.matchAll(/\b(?:href|src)="([^"]+)"/g)) {
  if (/^(https?:|mailto:)/.test(reference)) continue;
  if (reference.startsWith('#')) {
    if (!ids.includes(reference.slice(1))) errors.push(`Missing fragment: ${reference}`);
    continue;
  }
  const path = resolve(root, reference.split(/[?#]/)[0]);
  if (!path.startsWith(root + sep)) { errors.push(`Asset escapes site directory: ${reference}`); continue; }
  try { if (!(await stat(path)).isFile()) errors.push(`Not a file: ${reference}`); }
  catch { errors.push(`Missing asset: ${reference}`); }
}
for (const tag of html.matchAll(/<img\b[^>]*>/g)) {
  if (!/\balt="[^"]+"/.test(tag[0])) errors.push('Image missing descriptive alt text');
  if (!/\bwidth="\d+"/.test(tag[0]) || !/\bheight="\d+"/.test(tag[0])) errors.push('Image missing dimensions');
}
if (errors.length) { console.error(errors.join('\n')); process.exitCode = 1; }
else console.log('Site checks passed: metadata, heading, IDs, local assets, fragment links, image attributes.');

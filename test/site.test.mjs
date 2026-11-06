import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { Script } from 'node:vm';
const pages=['index','services','gallery','about','booking','contact','admin'];
const js=readFileSync('assets/site.js','utf8');
const css=readFileSync('assets/site.css','utf8');
new Script(js);
for(const page of pages){
 const html=readFileSync(page+'.html','utf8');
 assert.match(html,new RegExp('data-page="'+(page==='index'?'home':page)+'"'));
 assert.match(html,/assets\/site\.css/);assert.match(html,/assets\/site\.js/);
 assert.match(html,/noindex,nofollow/);
}
for(const name of ['attachBooking','attachAdmin','todayAthens','renderStats','carousel','serviceFilters'])assert.ok(js.includes(name),name);
for(const path of ['assets/site.css','assets/site.js','README.md'])assert.ok(existsSync(path));
assert.match(css,/@media\(max-width:760px\)/);
assert.match(css, /prefers-reduced-motion/);
assert.ok(!js.includes('service_role'), 'No service role key in client');
console.log('7 HTML pages, JS syntax, responsive CSS and demo features verified');

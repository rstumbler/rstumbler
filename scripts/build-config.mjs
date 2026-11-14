import fs from 'fs';
import path from 'path';

const envPath = path.resolve(process.cwd(), '.env');
let envVars = {};

if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf-8');
  envContent.split('\n').forEach(line => {
    const [key, ...value] = line.split('=');
    if (key && value.length > 0) {
      envVars[key.trim()] = value.join('=').trim().replace(/[\'"]/g, '');
    }
  });
}

const url = process.env.SUPABASE_URL || envVars.SUPABASE_URL || "";
const key = process.env.SUPABASE_ANON_KEY || envVars.SUPABASE_ANON_KEY || "";
const wa = process.env.WA_NUMBER || envVars.WA_NUMBER || "";

const output = `window.SELARA_CONFIG = {
  supabaseUrl: "${url}",
  supabaseAnonKey: "${key}",
  waNumber: "${wa}"
};`;

fs.writeFileSync(path.resolve(process.cwd(), 'runtime-config.js'), output);
console.log('runtime-config.js berhasil dibuat.');

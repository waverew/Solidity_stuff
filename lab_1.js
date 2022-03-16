import { isValidPrivate as _isValidPrivate, privateToPublic, isValidPublic as _isValidPublic, keccak256 } from 'ethereumjs-util';
import { randomBytes } from 'crypto';

let pattern ="1234";
let gen = true;
while (gen) {
let id = randomBytes(32).toString('hex');
const privatKeyBuffer = new Buffer.from(id, 'hex');
let isValidPrivate = _isValidPrivate(privatKeyBuffer);
if (!isValidPrivate) {
continue;
}
const publicKey = privateToPublic(privatKeyBuffer);
const isValidPublic = _isValidPublic(publicKey);
const pk = keccak256(publicKey);
const add = pk.toString('hex').substring(24);

if (add.startsWith(pattern)) {
gen = false;
console.log("Address is ", add);
console.log("Private key is ", privatKeyBuffer.toString("hex"))
}

}
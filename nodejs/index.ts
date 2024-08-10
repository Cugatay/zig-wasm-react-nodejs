import fs from "fs";
const source = fs.readFileSync("../main.wasm");

type Add = (a: number, b: number) => number;

WebAssembly.instantiate(source, {
  env: {
    print: (result: any) => {
      console.log(`Called inside WASM: ${result}`);
    },
  },
}).then((result) => {
  const add = result.instance.exports.add as Add;
  add(1, 2);
});

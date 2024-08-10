import { useEffect, useState } from "react";

interface WASMFunctions {
  memory: WebAssembly.Memory;
  add: (a: number, b: number) => number;
}

function App() {
  const [isLoading, setIsLoading] = useState(false);
  const [WasmExports, setWasmExports] = useState<WASMFunctions | undefined>(
    undefined,
  );

  useEffect(() => {
    WebAssembly.compileStreaming(fetch("main.wasm")).then((module) => {
      WebAssembly.instantiate(module, {
        env: {
          print: (result: string) => {
            console.log(`This is called inside WASM: ${result}`);
          },
        },
      }).then((result) => {
        const exports = result.exports as unknown as WASMFunctions;
        setWasmExports(exports);
        setIsLoading(false);
      });
    });
  }, []);

  console.log("ADDDDD");
  console.log(WasmExports);
  console.log(WasmExports?.add(5, 2));
  return (
    <div>
      {isLoading ? (
        <div>Loading...</div>
      ) : (
        <div>
          <div>Welcome to the Zig WASM, traveler</div>
          <div>
            Here is the solution to the 3 + 2 problem: {WasmExports?.add(5, 2)}
          </div>
          <div>Brilliant, isn't it (!)</div>
        </div>
      )}
    </div>
  );
}

export default App;

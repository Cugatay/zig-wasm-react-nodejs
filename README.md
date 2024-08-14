# Zig WASM in React

Hello there! Finding a codebase and documentation about something that very small percentage of people tries is the hardest thing to do in Zig Language, since the language both lacks rich documentations and it changes like, everyday!

But on the bright side, this is a good thing for an evolving and developing language, and the hardest thing being just that is also great, because that means the language itself is very well designed, so you can understand even the hardest concepts via just surfing around the codebase.

Therefore, with this repository I aim to share the way you can create WASM files that are reaaaally small (in my experiences, it was smaller than Rust 😲) and blazingly fast! This way, you can turn a shitty language called TypeScript and its one of the most popular framework called React into something amazing! Or you can use the `nodejs/index.ts` file as a reference for using WASM for also backend stuff!

Note: Zig part of this project has been tested with Zig versions `0.13` and `0.14.0-dev.571+f4f5b2bc4`

# Installing

After cloning the repository, you can use `bun install`, `pnpm install` or anything you want, but I initially worked with bun, which is written in Zig btw, lets go Zig!

For me, the most important part of the project is building the Zig in a way that it produces a freestanding binary, with all the functions you want to export, and in a small size. So, finding the way to do these 3 things at the same time was a little hard, spent a day with Reddit and YouTube, but with thanks to [@alberic89](https://github.com/alberic89), we have a build file that can generate a WASM binary with these specifications. You can look at [build.zig](https://github.com/Cugatay/zig-wasm-react-nodejs/blob/main/build.zig) file for documentation and details.

Now, to build a WASM binary, you just simply need to enter the build command on you shell. After that, your binary that's called `zig-wasm` will be generated in `/zig-out/bin` directory. To use it in React, you have to move it as `/react/public/main.wasm`

```bash
# In root directory:
zig build
mv ./zig-out/bin/main.wasm ./react/public/main.wasm
```

# Important Notes

We use React and useEffect hook to fetch main.wasm, after initiating the binary, we give required functions to Zig (functions called as `extern fn`) so it can perform the given function as a JavaScript call whenever we need to, and set functions state to the exported functions from Zig so we can use it outside of the hook.

The most important thing is: Don't use a state for only a function! So, I'm doing this: `setWasmExports(exports);` And I mean don't do this: `setAddFunction(result.exports.add as AddFunc);` This doesn't work, because WASM needs a memory to perform. And the `wasmExports` state is not just a set of functions that are exported from Wasm. There's also a variable called memory that you can see on `WASMFunctions` interface.

Normally, you don't have to specify `memory: WebAssembly.Memory;` in the interface, but since this is a documentation, I wanted to show this memory variable explicitly.

The nodejs.ts file works just fine, no need to do anything! But just one important note: Calling a function in Nodejs and React differs in a small way:

#### React:

```Typescript
...
}).then((result) => {
    const exports = result.exports as unknown as WASMFunctions;
...
```

#### NodeJS:

```Typescript
...
}).then((result) => {
  const add = result.instance.exports.add as Add;
...
```

So, you gotta add result.instance before getting exports. Just keep that in mind!

# The End

Now, what you have in your hands are:

- A fast main.wasm file
- A great and Ziggy developer experience
- A WASM file that is even smaller than 1 byte
- React and NodeJS projects that work with WASM

Thanks for giving a chance to this piece of code!

And I strongly recommend you to look at these sources too:

- [Zig Web Assembly Language Reference](https://ziglang.org/documentation/0.9.0/#WebAssembly)
- [Dude the Builder Web Assembly Video \(He also talks about memory allocation on Zig WASM Applications)](https://youtu.be/tG8-xXQlS6Q)

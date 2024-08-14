# We can use this command to generate a lightweight and JS adaptable Wasm binary:
zig build-exe src/main.zig -target wasm32-freestanding -fno-entry -rdynamic -OReleaseSmall

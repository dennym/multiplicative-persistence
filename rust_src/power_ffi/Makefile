ifeq ($(shell uname),Darwin)
    EXT := dylib
else
    EXT := so
endif

all: target/debug/libpow.$(EXT)
	ruby src/cash_flow_rust_ffi.rb

target/debug/libpow.$(EXT): src/lib.rs Cargo.toml
	cargo build

clean:
	rm -rf target
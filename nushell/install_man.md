```nu
cargo install nu_plugin_polars --locked
cargo install nu_plugin_formats --locked
cargo install nu_plugin_gstat --locked
cargo install nu_plugin_query --locked
cargo install nu_plugin_inc --locked

plugin add ~/Application/Scoop/persist/rustup/.cargo/bin/nu_plugin_polars
plugin add ~/Application/Scoop/persist/rustup/.cargo/bin/nu_plugin_formats
plugin add ~/Application/Scoop/persist/rustup/.cargo/bin/nu_plugin_gstat
plugin add ~/Application/Scoop/persist/rustup/.cargo/bin/nu_plugin_query
plugin add ~/Application/Scoop/persist/rustup/.cargo/bin/nu_plugin_inc

plugin list
```
# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo systemd user

DESCRIPTION="A Mirakurun-compatible PVR backend written in Rust"
HOMEPAGE="https://github.com/mirakc/mirakc"
CRATES="
actix-0.12.0
actix-codec-0.4.0
actix-files-0.6.0-beta.8
actix-http-3.0.0-beta.11
actix-macros-0.2.3
actix-router-0.5.0-beta.2
actix-rt-2.3.0
actix-server-2.0.0-beta.6
actix-service-2.0.1
actix-tls-3.0.0-beta.7
actix-utils-3.0.0
actix-web-4.0.0-beta.10
actix-web-codegen-0.5.0-beta.5
actix_derive-0.6.0
addr2line-0.16.0
adler-1.0.2
ahash-0.7.6
aho-corasick-0.7.18
ansi_term-0.11.0
ansi_term-0.12.1
askama_escape-0.10.1
assert_matches-1.5.0
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.62
base-x-0.2.8
base64-0.13.0
bitflags-1.3.2
block-buffer-0.9.0
brotli-sys-0.3.2
brotli2-0.3.2
bumpalo-3.8.0
byteorder-1.4.3
bytes-1.1.0
bytestring-1.0.0
cc-1.0.71
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
const_fn-0.4.8
convert_case-0.4.0
cookie-0.15.1
cpufeatures-0.2.1
crc32fast-1.2.1
cron-0.9.0
crossbeam-channel-0.5.1
crossbeam-utils-0.8.5
derive_more-0.99.16
digest-0.9.0
discard-1.0.4
dtoa-0.4.8
either-1.6.1
encoding_rs-0.8.29
failure-0.1.8
failure_derive-0.1.8
firestorm-0.4.6
flate2-1.0.22
fnv-1.0.7
form_urlencoded-1.0.1
fs2-0.4.3
fuser-0.9.1
futures-0.3.17
futures-channel-0.3.17
futures-core-0.3.17
futures-executor-0.3.17
futures-io-0.3.17
futures-macro-0.3.17
futures-sink-0.3.17
futures-task-0.3.17
futures-util-0.3.17
generic-array-0.14.4
getrandom-0.2.3
gimli-0.25.0
h2-0.3.7
hashbrown-0.11.2
hermit-abi-0.1.19
http-0.2.5
http-range-0.1.4
httparse-1.5.1
httpdate-1.0.1
humantime-2.1.0
idna-0.2.3
indexmap-1.7.0
instant-0.1.12
itertools-0.10.1
itoa-0.4.8
jobserver-0.1.24
language-tags-0.3.2
lazy_static-1.4.0
libc-0.2.107
linked-hash-map-0.5.4
local-channel-0.1.2
local-waker-0.1.1
lock_api-0.4.5
log-0.3.9
log-0.4.14
maplit-1.0.2
matchers-0.1.0
matches-0.1.9
memchr-2.4.1
mime-0.3.16
mime_guess-2.0.3
miniz_oxide-0.4.4
mio-0.7.14
miow-0.3.7
mustache-0.9.0
nom-4.1.1
ntapi-0.3.6
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.27.1
once_cell-1.8.0
opaque-debug-0.3.0
page_size-0.4.2
parking_lot-0.11.2
parking_lot_core-0.8.5
paste-1.0.5
percent-encoding-2.1.0
pest-2.1.3
pin-project-1.0.8
pin-project-internal-1.0.8
pin-project-lite-0.2.7
pin-utils-0.1.0
pkg-config-0.3.21
ppv-lite86-0.2.14
proc-macro-hack-0.5.19
proc-macro-nested-0.1.7
proc-macro2-1.0.30
quote-1.0.10
rand-0.8.4
rand_chacha-0.3.1
rand_core-0.6.3
rand_hc-0.3.1
redox_syscall-0.2.10
regex-1.5.4
regex-automata-0.1.10
regex-syntax-0.6.25
rustc-demangle-0.1.21
rustc_version-0.2.3
rustc_version-0.3.3
ryu-1.0.5
sanitize-filename-0.3.0
scopeguard-1.1.0
semver-0.9.0
semver-0.11.0
semver-parser-0.7.0
semver-parser-0.10.2
serde-1.0.130
serde_derive-1.0.130
serde_json-1.0.69
serde_qs-0.8.5
serde_urlencoded-0.7.0
serde_yaml-0.8.21
sha-1-0.9.8
sha1-0.6.0
sharded-slab-0.1.4
shell-words-1.0.0
signal-hook-registry-1.4.0
slab-0.4.5
smallvec-1.7.0
socket2-0.4.2
standback-0.2.17
stdweb-0.4.20
stdweb-derive-0.5.3
stdweb-internal-macros-0.2.9
stdweb-internal-runtime-0.1.5
strsim-0.8.0
syn-1.0.80
synstructure-0.12.6
textwrap-0.11.0
thiserror-1.0.30
thiserror-impl-1.0.30
thread_local-1.1.3
time-0.1.44
time-0.2.27
time-0.3.3
time-macros-0.1.1
time-macros-impl-0.1.2
tinyvec-1.5.0
tinyvec_macros-0.1.0
tokio-1.13.0
tokio-macros-1.5.0
tokio-stream-0.1.8
tokio-util-0.6.9
tracing-0.1.29
tracing-attributes-0.1.18
tracing-core-0.1.21
tracing-log-0.1.2
tracing-serde-0.1.2
tracing-subscriber-0.3.1
typenum-1.14.0
ucd-trie-0.1.3
unicase-2.6.0
unicode-bidi-0.3.7
unicode-normalization-0.1.19
unicode-width-0.1.9
unicode-xid-0.2.2
url-2.2.2
users-0.11.0
vec_map-0.8.2
version_check-0.9.3
wasi-0.10.0+wasi-snapshot-preview1
wasm-bindgen-0.2.78
wasm-bindgen-backend-0.2.78
wasm-bindgen-macro-0.2.78
wasm-bindgen-macro-support-0.2.78
wasm-bindgen-shared-0.2.78
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.5
zerocopy-0.5.0
zerocopy-derive-0.3.0
zstd-0.7.0+zstd.1.4.9
zstd-safe-3.1.0+zstd.1.4.9
zstd-sys-1.5.0+zstd.1.4.9
"
SRC_URI="https://github.com/mirakc/mirakc/archive/${PV}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=media-tv/mirakc-arib-0.16.6"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	enewgroup mirakc
	enewuser mirakc -1 -1 /var/lib/mirakc mirakc
}

src_install() {
	cargo_src_install --path ./mirakc
	cargo_src_install --path ./mirakc-timeshift-fs

	dodir /var/lib/mirakc/epg
	keepdir /var/lib/mirakc/epg

	insinto /etc/mirakc
	doins "${S}"/resources/strings.yml
	insinto /etc
	doins "${S}"/resources/mirakurun.openapi.json

	fowners mirakc:mirakc /var/lib/mirakc
	fperms 0750 /var/lib/mirakc

	systemd_dounit "${FILESDIR}/mirakc.service"
}


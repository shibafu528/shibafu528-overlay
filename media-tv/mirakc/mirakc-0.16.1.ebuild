# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo systemd user

DESCRIPTION="A Mirakurun clone written in Rust"
HOMEPAGE="https://github.com/mirakc/mirakc"
CRATES="
actix-0.10.0
actix-codec-0.3.0
actix-connect-2.0.0
actix-files-0.5.0
actix-http-2.2.0
actix-macros-0.1.3
actix-router-0.2.5
actix-rt-1.1.1
actix-server-1.0.4
actix-service-1.0.6
actix-testing-1.0.1
actix-threadpool-0.3.3
actix-tls-2.0.0
actix-utils-2.0.0
actix-web-3.3.2
actix-web-codegen-0.4.0
actix_derive-0.5.0
addr2line-0.14.0
adler-0.2.3
aho-corasick-0.7.15
ansi_term-0.11.0
ansi_term-0.12.1
assert_matches-1.4.0
async-trait-0.1.42
atty-0.2.14
autocfg-1.0.1
awc-2.0.3
backtrace-0.3.55
base-x-0.2.8
base64-0.13.0
bitflags-1.2.1
block-buffer-0.9.0
brotli-sys-0.3.2
brotli2-0.3.2
buf-min-0.4.0
bumpalo-3.4.0
byteorder-1.3.4
bytes-0.5.6
bytestring-0.1.5
cc-1.0.66
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
const_fn-0.4.4
cookie-0.14.3
copyless-0.1.5
cpuid-bool-0.1.2
crc32fast-1.2.1
cron-0.7.0
crossbeam-channel-0.4.4
crossbeam-utils-0.7.2
derive_more-0.99.11
digest-0.9.0
discard-1.0.4
dtoa-0.4.6
either-1.6.1
encoding_rs-0.8.26
enum-as-inner-0.3.3
error-chain-0.10.0
failure-0.1.8
failure_derive-0.1.8
flate2-1.0.19
fnv-1.0.7
form_urlencoded-1.0.0
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.3.8
futures-channel-0.3.8
futures-core-0.3.8
futures-executor-0.3.8
futures-io-0.3.8
futures-macro-0.3.8
futures-sink-0.3.8
futures-task-0.3.8
futures-util-0.3.8
fxhash-0.2.1
generator-0.6.23
generic-array-0.14.4
getrandom-0.1.15
gimli-0.23.0
h2-0.2.7
hashbrown-0.9.1
heck-0.3.1
hermit-abi-0.1.17
hostname-0.3.1
http-0.2.2
httparse-1.3.4
humantime-2.0.1
idna-0.2.0
indexmap-1.6.1
instant-0.1.9
iovec-0.1.4
ipconfig-0.2.2
itoa-0.4.6
kernel32-sys-0.2.2
language-tags-0.2.2
lazy_static-1.4.0
libc-0.2.81
linked-hash-map-0.5.3
lock_api-0.4.2
log-0.3.9
log-0.4.11
loom-0.3.6
lru-cache-0.1.2
match_cfg-0.1.0
matchers-0.0.1
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.3.4
mime-0.3.16
mime_guess-2.0.3
miniz_oxide-0.4.3
mio-0.6.23
mio-named-pipes-0.1.7
mio-uds-0.6.8
miow-0.2.2
miow-0.3.6
mustache-0.9.0
net2-0.2.37
nom-4.1.1
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.22.0
once_cell-1.5.2
opaque-debug-0.3.0
parking_lot-0.11.1
parking_lot_core-0.8.1
percent-encoding-2.1.0
pin-project-0.4.27
pin-project-1.0.2
pin-project-internal-0.4.27
pin-project-internal-1.0.2
pin-project-lite-0.1.11
pin-project-lite-0.2.0
pin-utils-0.1.0
ppv-lite86-0.2.10
proc-macro-hack-0.5.19
proc-macro-nested-0.1.6
proc-macro2-1.0.24
quick-error-1.2.3
quote-1.0.7
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
redox_syscall-0.1.57
regex-1.4.2
regex-automata-0.1.9
regex-syntax-0.6.21
resolv-conf-0.7.0
rustc-demangle-0.1.18
rustc_version-0.2.3
ryu-1.0.5
scoped-tls-1.0.0
scopeguard-1.1.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.118
serde_derive-1.0.118
serde_json-1.0.61
serde_qs-0.8.2
serde_urlencoded-0.7.0
serde_yaml-0.8.14
sha-1-0.9.2
sha1-0.6.0
sharded-slab-0.1.0
shell-words-1.0.0
signal-hook-registry-1.2.2
slab-0.4.2
smallvec-1.5.1
socket2-0.3.18
standback-0.2.13
stdweb-0.4.20
stdweb-derive-0.5.3
stdweb-internal-macros-0.2.9
stdweb-internal-runtime-0.1.5
strsim-0.8.0
syn-1.0.54
synstructure-0.12.4
textwrap-0.11.0
thiserror-1.0.22
thiserror-impl-1.0.22
thread_local-1.0.1
threadpool-1.8.1
time-0.1.44
time-0.2.23
time-macros-0.1.1
time-macros-impl-0.1.1
tinyvec-1.1.0
tinyvec_macros-0.1.0
tokio-0.2.24
tokio-macros-0.2.6
tokio-util-0.3.1
tracing-0.1.22
tracing-attributes-0.1.11
tracing-core-0.1.17
tracing-futures-0.2.4
tracing-log-0.1.1
tracing-serde-0.1.2
tracing-subscriber-0.2.15
trust-dns-proto-0.19.6
trust-dns-resolver-0.19.6
typenum-1.12.0
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.16
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
url-2.2.0
v_escape-0.15.0
v_escape_derive-0.8.4
v_htmlescape-0.12.0
vec_map-0.8.2
version_check-0.9.2
wasi-0.9.0+wasi-snapshot-preview1
wasi-0.10.0+wasi-snapshot-preview1
wasm-bindgen-0.2.69
wasm-bindgen-backend-0.2.69
wasm-bindgen-macro-0.2.69
wasm-bindgen-macro-support-0.2.69
wasm-bindgen-shared-0.2.69
widestring-0.4.3
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
yaml-rust-0.4.4
"
SRC_URI="https://github.com/mirakc/mirakc/archive/${PV}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=media-tv/mirakc-arib-0.10.2"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
	enewgroup mirakc
	enewuser mirakc -1 -1 /var/lib/mirakc mirakc
}

src_install() {
	cargo_src_install

	dodir /var/lib/mirakc/epg
	keepdir /var/lib/mirakc/epg

	insinto /etc/mirakc
	doins "${S}"/resources/strings.yml

	fowners mirakc:mirakc /var/lib/mirakc
	fperms 0750 /var/lib/mirakc

	systemd_dounit "${FILESDIR}/mirakc.service"
}


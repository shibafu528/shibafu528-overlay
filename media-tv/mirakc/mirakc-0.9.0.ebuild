# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo systemd user

DESCRIPTION="A Mirakurun clone written in Rust"
HOMEPAGE="https://github.com/masnagam/mirakc"
CRATES="
actix-0.9.0
actix-codec-0.2.0
actix-connect-1.0.2
actix-files-0.2.1
actix-http-1.0.1
actix-macros-0.1.2
actix-router-0.2.4
actix-rt-1.1.1
actix-server-1.0.3
actix-service-1.0.5
actix-testing-1.0.1
actix-threadpool-0.3.2
actix-tls-1.0.0
actix-utils-1.0.6
actix-web-2.0.0
actix-web-codegen-0.2.2
actix_derive-0.5.0
addr2line-0.12.1
adler32-1.0.4
aho-corasick-0.7.10
ansi_term-0.11.0
arc-swap-0.4.6
async-trait-0.1.31
atty-0.2.14
autocfg-1.0.0
awc-1.0.1
backtrace-0.3.48
base64-0.11.0
bitflags-1.2.1
brotli-sys-0.3.2
brotli2-0.3.2
byteorder-1.3.4
bytes-0.5.4
bytestring-0.1.5
cc-1.0.54
cfg-if-0.1.10
chrono-0.4.11
clap-2.33.1
cloudabi-0.0.3
copyless-0.1.4
crc32fast-1.2.0
cron-0.6.0
crossbeam-channel-0.4.2
crossbeam-utils-0.7.2
derive_more-0.99.7
dtoa-0.4.5
either-1.5.3
encoding_rs-0.8.23
enum-as-inner-0.3.2
error-chain-0.10.0
failure-0.1.8
failure_derive-0.1.8
flate2-1.0.14
fnv-1.0.7
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.3.5
futures-channel-0.3.5
futures-core-0.3.5
futures-executor-0.3.5
futures-io-0.3.5
futures-macro-0.3.5
futures-sink-0.3.5
futures-task-0.3.5
futures-util-0.3.5
fxhash-0.2.1
getrandom-0.1.14
gimli-0.21.0
h2-0.2.5
heck-0.3.1
hermit-abi-0.1.13
hostname-0.3.1
http-0.2.1
httparse-1.3.4
humantime-2.0.0
idna-0.2.0
indexmap-1.3.2
iovec-0.1.4
ipconfig-0.2.2
itoa-0.4.5
kernel32-sys-0.2.2
language-tags-0.2.2
lazy_static-1.4.0
libc-0.2.70
linked-hash-map-0.5.3
lock_api-0.3.4
log-0.3.9
log-0.4.8
lru-cache-0.1.2
match_cfg-0.1.0
matchers-0.0.1
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.3.3
mime-0.3.16
mime_guess-2.0.3
miniz_oxide-0.3.6
mio-0.6.22
mio-named-pipes-0.1.6
mio-uds-0.6.8
miow-0.2.1
miow-0.3.4
mustache-0.9.0
net2-0.2.34
nom-2.1.0
nom-4.2.3
num-integer-0.1.42
num-traits-0.2.11
num_cpus-1.13.0
object-0.19.0
once_cell-1.4.0
parking_lot-0.10.2
parking_lot_core-0.7.2
percent-encoding-2.1.0
pin-project-0.4.17
pin-project-internal-0.4.17
pin-project-lite-0.1.5
pin-utils-0.1.0
ppv-lite86-0.2.8
proc-macro-hack-0.5.16
proc-macro-nested-0.1.4
proc-macro2-1.0.17
quick-error-1.2.3
quote-1.0.6
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
redox_syscall-0.1.56
regex-1.3.7
regex-automata-0.1.9
regex-syntax-0.6.17
resolv-conf-0.6.3
rustc-demangle-0.1.16
ryu-1.0.4
scopeguard-1.1.0
serde-1.0.110
serde_derive-1.0.110
serde_json-1.0.53
serde_urlencoded-0.6.1
serde_yaml-0.8.12
sha1-0.6.0
sharded-slab-0.0.9
shell-words-1.0.0
signal-hook-registry-1.2.0
slab-0.4.2
smallvec-1.4.0
socket2-0.3.12
strsim-0.8.0
syn-1.0.25
synstructure-0.12.3
textwrap-0.11.0
thread_local-1.0.1
threadpool-1.8.1
time-0.1.43
tokio-0.2.21
tokio-macros-0.2.5
tokio-util-0.2.0
tokio-util-0.3.1
tracing-0.1.14
tracing-attributes-0.1.8
tracing-core-0.1.10
tracing-futures-0.2.4
tracing-log-0.1.1
tracing-serde-0.1.1
tracing-subscriber-0.2.5
trust-dns-proto-0.18.0-alpha.2
trust-dns-resolver-0.18.0-alpha.2
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.12
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
url-2.1.1
v_escape-0.7.4
v_escape_derive-0.5.6
v_htmlescape-0.4.5
vec_map-0.8.2
version_check-0.1.5
version_check-0.9.2
wasi-0.9.0+wasi-snapshot-preview1
widestring-0.4.0
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
ws2_32-sys-0.2.1
yaml-rust-0.4.3
"
SRC_URI="https://github.com/masnagam/mirakc/archive/${PV}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=media-tv/mirakc-arib-0.6.1"
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

	fowners mirakc:mirakc /var/lib/mirakc
	fperms 0750 /var/lib/mirakc

	systemd_dounit "${FILESDIR}/mirakc.service"
}


# Package-manager detection for daddy bootstrap scripts.
# detect_pkg_manager prints "dnf" or "apt"; unsupported hosts exit non-zero.

detect_pkg_manager() {
  if command -v dnf >/dev/null 2>&1; then
    echo dnf
    return 0
  fi
  if command -v apt-get >/dev/null 2>&1; then
    echo apt
    return 0
  fi
  echo "No supported package manager (dnf or apt-get) found." >&2
  return 1
}

install_bootstrap_packages() {
  local pm
  pm=$(detect_pkg_manager) || return 1

  case "$pm" in
    dnf)
      sudo dnf install -y -q sudo wget
      ;;
    apt)
      sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq sudo wget
      ;;
    *)
      echo "Unsupported package manager: $pm" >&2
      return 1
      ;;
  esac
}
#!/usr/bin/env bash
# Claude Code statusline
# user@host <gituser>  dir  branch  の横に
# モデル / コンテキスト使用率バー / コスト / レート制限 / 経過時間 を表示。
# 配色は Catppuccin 系パステル (目に優しい中彩度・中明度)。
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // empty')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
CTX_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
COST_USD=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
FIVE=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# ---- パレット (Catppuccin Mocha 系) ----------------------------------------
RESET='\033[0m'
C_USER='\033[1;38;2;243;139;168m'   # soft red  (user@host, 太字)
C_DIR='\033[38;2;137;180;250m'      # soft blue (dir)
C_BR='\033[38;2;148;226;213m'       # teal      (branch)
C_MODEL='\033[38;2;203;166;247m'    # mauve     (model)
C_COST='\033[38;2;166;227;161m'     # green     (cost)
C_SUB='\033[38;2;186;194;222m'      # subtext   (rate / time)

USER_N=$(whoami)
HOST_N=$(hostname -s)
[ -z "$DIR" ] && DIR=$(pwd)

cd "$DIR" 2>/dev/null || true

# ディレクトリ (~ 省略, フルパス表記 = zsh %~ 相当)
case "$DIR" in
  "$HOME")   DISP='~' ;;
  "$HOME"/*) DISP="~${DIR#"$HOME"}" ;;
  *)         DISP="$DIR" ;;
esac
# worktree パスはプロジェクトルートまで畳む (ブランチ名と重複するため)
case "$DISP" in
  */.claude/worktrees/*) DISP="${DISP%%/.claude/worktrees/*}" ;;
esac

# git ブランチ + dirty マーカー (+: ステージ済 / !: 未ステージ)
VCS=""
BR=$(git branch --show-current 2>/dev/null)
[ -z "$BR" ] && BR=$(git symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$BR" ]; then
  MK=""
  git diff --cached --quiet 2>/dev/null || MK="${MK}+"
  git diff --quiet 2>/dev/null || MK="${MK}!"
  VCS="  ${C_BR}${BR}${RESET}"
  [ -n "$MK" ] && VCS="${VCS} ${C_BR}${MK}${RESET}"
fi

# プレフィックス: user@host  dir  branch (アイコン・カッコなし)
PREFIX="${C_USER}${USER_N}@${HOST_N}${RESET}  ${C_DIR}${DISP}${RESET}${VCS}"

# コンテキスト使用率バー (パステル 緑→黄→赤 で補間。1M 想定: 15% で黄 / 40% で赤)
lerp() { echo $(( $1 + ($2 - $1) * $3 / $4 )); }   # a + (b-a)*num/den
gradient_bar() {
  local label="$1"
  local pct
  pct=$(printf '%.0f' "$2" 2>/dev/null || echo 0)
  [ "$pct" -gt 100 ] && pct=100
  [ "$pct" -lt 0 ] && pct=0
  local r g b
  if [ "$pct" -lt 15 ]; then          # 緑(166,227,161) → 黄(249,226,175)
    r=$(lerp 166 249 "$pct" 15); g=$(lerp 227 226 "$pct" 15); b=$(lerp 161 175 "$pct" 15)
  elif [ "$pct" -lt 40 ]; then        # 黄(249,226,175) → 赤(243,139,168)
    local n=$((pct - 15))
    r=$(lerp 249 243 "$n" 25); g=$(lerp 226 139 "$n" 25); b=$(lerp 175 168 "$n" 25)
  else                                # 赤(243,139,168)
    r=243; g=139; b=168
  fi
  local color="\033[38;2;${r};${g};${b}m"
  local width=10
  local blocks=' ▏▎▍▌▋▊▉█'
  local filled=$((pct * width / 100))
  local frac_idx=$(( (pct * width % 100) * 8 / 100 ))
  local bar=""
  for ((i=0; i<filled; i++)); do bar+="█"; done
  if [ "$filled" -lt "$width" ]; then
    bar+="${blocks:$frac_idx:1}"
    for ((i=filled+1; i<width; i++)); do bar+="░"; done
  fi
  echo -ne "${C_SUB}${label} ${color}${bar} ${pct}%${RESET}"
}

# 経過時間 / コスト
MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))
COST_FMT=$(printf '$%.2f' "$COST_USD")
SEP="  "   # 区切りはスペース2つ

# 出力: 1 行目 = user@host dir branch / 2 行目 = モデル・コンテキスト等
LINE2="${C_MODEL}${MODEL}${RESET}"
LINE2+="${SEP}$(gradient_bar 'ctx' "$CTX_PCT")"
LINE2+="${SEP}${C_SUB}💰${RESET} ${C_COST}${COST_FMT}${RESET}"
[ -n "$FIVE" ] && LINE2+="${SEP}${C_SUB}5h $(printf '%.0f' "$FIVE")%${RESET}"
[ -n "$WEEK" ] && LINE2+="${SEP}${C_SUB}7d $(printf '%.0f' "$WEEK")%${RESET}"
LINE2+="${SEP}${C_SUB}⏱️ ${MINS}m${SECS}s${RESET}"
printf '%b\n%b' "$PREFIX" "$LINE2"

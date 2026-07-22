#!/bin/bash
set -euo pipefail

# ==========================================
# SKA HOST MULTI-TOOL (VM MANAGER - NO KVM)
# STYLE: SLEEK CYBERPUNK + RESPONSIVE UI
# BACKEND: PURE QEMU (SOFTWARE EMULATION)
# ==========================================

# 🎨 Premium Colors (High-Intensity ANSI)
R='\033[1;91m'      # Bright Red
G='\033[1;92m'      # Bright Green
Y='\033[1;93m'      # Bright Yellow
B='\033[1;94m'      # Bright Blue
P='\033[1;95m'      # Bright Magenta
C='\033[1;96m'      # Bright Cyan
W='\033[1;97m'      # Bright White
DG='\033[1;90m'     # Dark Gray
BLINK='\033[5m'     # Blinking
NC='\033[0m'        # No Color

# ==========================================
# 🎬 UI COMPONENTS & ANIMATIONS
# ==========================================

# Responsive Terminal Checker
get_term_width() {
    local width=$(tput cols 2>/dev/null)
    if [[ -z "$width" || "$width" -lt 40 ]]; then width=55; fi
    echo "$width"
}

# Wait / Pause Prompt
pause() { 
    echo -e "\n  ${DG}╭─────────────────────────────────────────────────────────╮${NC}"
    read -p "$(echo -e "  ${DG}│${NC} ↩ Press ${W}Enter${NC} to continue... ")" _ 
}

# Smooth Typing Effect
type_effect() {
    local text="$1"
    local speed="$2"
    for (( i=0; i<${#text}; i++ )); do
        echo -en "${text:$i:1}"
        sleep "$speed"
    done
    echo ""
}

# Cyberpunk Spinner Loading Screen
boot_sequence() {
    clear
    echo -e "\n\n"
    local text="${C}  [SYS] Establishing secure connection to SKA HOST Engine...${NC}"
    type_effect "$text" 0.02
    
    local chars="/-\|"
    echo -ne "  ${P}Authenticating: ${NC}"
    for i in {1..15}; do
        echo -ne "\b${G}${chars:i%4:1}${NC}"
        sleep 0.1
    done
    
    echo -e "\b${G}SUCCESS!${NC}"
    echo -ne "  ${C}Booting Hypervisor Core [${NC}"
    for ((i = 0; i < 35; i++)); do
        echo -ne "${P}■${NC}"
        sleep 0.02
    done
    echo -e "${C}] 100%${NC}"
    sleep 0.3
}

# Main Dashboard UI
show_dashboard() {
    clear
    local UPTIME=$(uptime -p | sed -e 's/up //' -e 's/ hours/h/' -e 's/ hour/h/' -e 's/ minutes/m/' -e 's/ minute/m/' -e 's/ days/d/' -e 's/ day/d/' -e 's/,//g') 
    local CPU_LOAD=$(top -bn1 | grep load | awk '{printf "%.2f", $(NF-2)}')
    local RAM_FREE=$(free -m | awk '/Mem:/ { printf("%.0f%%", $3/$2 * 100.0) }')
    local WIDTH=$(get_term_width)

    echo -e "${C}╭──────────────────────────────────────────────────────────────╮${NC}"
    echo -e "${C}│${NC} ${W}⚡ SKA HOST VIRTUAL MACHINE ENGINE (PURE QEMU)             ${C}│${NC}"
    echo -e "${C}├──────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${C}│${NC}  ${BLINK}${G}● ONLINE${NC}   ${DG}|${NC}   ⏱️ ${C}UP:${NC} ${W}${UPTIME:0:10}${NC}   ${DG}|${NC}   🧠 ${C}CPU:${NC} ${W}${CPU_LOAD}%${NC}   ${DG}|${NC}   💾 ${C}RAM:${NC} ${W}${RAM_FREE}${NC}"
    echo -e "${C}╰──────────────────────────────────────────────────────────────╯${NC}"
    echo ""
}

# Beautiful Status Messages
print_status() {
    local type=$1
    local message=$2
    case $type in
        "INFO") echo -e "  ${C}ℹ️  [INFO]${NC} $message" ;;
        "WARN") echo -e "  ${Y}⚠️  [WARN]${NC} $message" ;;
        "ERROR") echo -e "  ${R}❌ [ERR]${NC} $message" ;;
        "SUCCESS") echo -e "  ${G}✔️  [OK]${NC} $message" ;;
    esac
}

# Sleek Input Prompt Helper
prompt_input() {
    local text=$1
    echo -e "      ${C}➤${NC} ${text}"
}


# ==========================================
# 🛠️ BACKEND LOGIC (NO KVM)
# ==========================================

check_image_lock() {
    local img_file=$1
    local vm_name=$2
    
    if lsof "$img_file" 2>/dev/null | grep -q qemu-system; then
        print_status "WARN" "Image file is in use by another process."
        local pid=$(lsof "$img_file" 2>/dev/null | grep qemu-system | awk '{print $2}' | head -1)
        if [[ -n "$pid" ]]; then
            if ps -p "$pid" -o cmd= | grep -q "$vm_name"; then
                read -p "$(echo -e "  ${Y}╰─➤${NC} Kill & Restart? (y/N): ")" kill_choice
                if [[ "$kill_choice" =~ ^[Yy]$ ]]; then
                    kill "$pid"; sleep 2
                    if kill -0 "$pid" 2>/dev/null; then kill -9 "$pid"; fi
                    return 0
                else
                    return 1
                fi
            else
                print_status "ERROR" "Another QEMU instance is using this image."
                return 1
            fi
        fi
        return 1
    fi
    
    local lock_file="${img_file}.lock"
    if [[ -f "$lock_file" ]]; then
        if [[ $(find "$lock_file" -mmin +5 2>/dev/null) ]]; then
            read -p "$(echo -e "  ${Y}╰─➤${NC} Stale lock found. Remove? (y/N): ")" remove_lock
            if [[ "$remove_lock" =~ ^[Yy]$ ]]; then
                rm -f "$lock_file"; return 0
            else
                return 1
            fi
        fi
        return 1
    fi
    return 0
}

validate_input() {
    local type=$1
    local value=$2
    case $type in
        "number") if ! [[ "$value" =~ ^[0-9]+$ ]]; then print_status "ERROR" "Must be a number"; return 1; fi ;;
        "size") if ! [[ "$value" =~ ^[0-9]+[GgMm]$ ]]; then print_status "ERROR" "Format: 100G, 512M"; return 1; fi ;;
        "port") if ! [[ "$value" =~ ^[0-9]+$ ]] || [ "$value" -lt 23 ] || [ "$value" -gt 65535 ]; then print_status "ERROR" "Valid port (23-65535)"; return 1; fi ;;
        "name") if ! [[ "$value" =~ ^[a-zA-Z0-9_-]+$ ]]; then print_status "ERROR" "Only letters, numbers, hyphens, underscores"; return 1; fi ;;
        "username") if ! [[ "$value" =~ ^[a-z_][a-z0-9_-]*$ ]]; then print_status "ERROR" "Invalid username format"; return 1; fi ;;
    esac
    return 0
}

check_dependencies() {
    local deps=("qemu-system-x86_64" "wget" "cloud-localds" "qemu-img" "lsof")
    local missing_deps=()
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then missing_deps+=("$dep"); fi
    done
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_status "ERROR" "Missing dependencies: ${missing_deps[*]}"
        print_status "INFO" "Run: sudo apt install qemu-system cloud-image-utils wget lsof"
        exit 1
    fi
}

cleanup() {
    rm -f "user-data" "meta-data" 2>/dev/null || true
}

get_vm_list() {
    find "$VM_DIR" -name "*.conf" -exec basename {} .conf \; 2>/dev/null | sort
}

load_vm_config() {
    local vm_name=$1
    local config_file="$VM_DIR/$vm_name.conf"
    if [[ -f "$config_file" ]]; then
        unset VM_NAME OS_TYPE CODENAME IMG_URL HOSTNAME USERNAME PASSWORD
        unset DISK_SIZE MEMORY CPUS SSH_PORT GUI_MODE PORT_FORWARDS IMG_FILE SEED_FILE CREATED
        source "$config_file"
        return 0
    else
        print_status "ERROR" "VM '$vm_name' config not found."
        return 1
    fi
}

save_vm_config() {
    cat > "$VM_DIR/$VM_NAME.conf" <<EOF
VM_NAME="$VM_NAME"
OS_TYPE="$OS_TYPE"
CODENAME="$CODENAME"
IMG_URL="$IMG_URL"
HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"
PASSWORD="$PASSWORD"
DISK_SIZE="$DISK_SIZE"
MEMORY="$MEMORY"
CPUS="$CPUS"
SSH_PORT="$SSH_PORT"
GUI_MODE="$GUI_MODE"
PORT_FORWARDS="$PORT_FORWARDS"
IMG_FILE="$IMG_FILE"
SEED_FILE="$SEED_FILE"
CREATED="$CREATED"
EOF
}

create_new_vm() {
    print_status "INFO" "Creating a new Virtual Machine"
    
    echo -e "\n  ${P}╭─[ 🌐 SELECT OPERATING SYSTEM ]${NC}"
    local os_options=()
    local i=1
    for os in "${!OS_OPTIONS[@]}"; do
        printf "  ${P}│${NC}  ${DG}[${Y}%2d${DG}]${NC} %-35s\n" "$i" "$os"
        os_options[$i]="$os"
        ((i++))
    done
    echo -e "  ${P}╰────────────────────────────────────────${NC}\n"
    
    while true; do
        read -p "$(echo -e "  ${P}╰─➤${NC} Select OS [1-${#OS_OPTIONS[@]}]: ")" choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#OS_OPTIONS[@]} ]; then
            local os="${os_options[$choice]}"
            IFS='|' read -r OS_TYPE CODENAME IMG_URL DEFAULT_HOSTNAME DEFAULT_USERNAME DEFAULT_PASSWORD <<< "${OS_OPTIONS[$os]}"
            break
        else
            print_status "ERROR" "Invalid selection."
        fi
    done

    echo -e "\n  ${C}╭─[ ⚙️  VM CONFIGURATION ]${NC}"
    
    while true; do
        read -p "$(prompt_input "VM Name [${DEFAULT_HOSTNAME}]: ")" VM_NAME
        VM_NAME="${VM_NAME:-$DEFAULT_HOSTNAME}"
        if validate_input "name" "$VM_NAME"; then
            if [[ -f "$VM_DIR/$VM_NAME.conf" ]]; then print_status "ERROR" "Name taken!"; else break; fi
        fi
    done

    read -p "$(prompt_input "Hostname [${VM_NAME}]: ")" HOSTNAME; HOSTNAME="${HOSTNAME:-$VM_NAME}"
    read -p "$(prompt_input "Username [${DEFAULT_USERNAME}]: ")" USERNAME; USERNAME="${USERNAME:-$DEFAULT_USERNAME}"
    
    while true; do
        read -rs -p "$(prompt_input "Password [${DEFAULT_PASSWORD}]: ")" PASSWORD; echo ""
        PASSWORD="${PASSWORD:-$DEFAULT_PASSWORD}"
        if [ -n "$PASSWORD" ]; then break; else print_status "ERROR" "Password cannot be empty"; fi
    done

    read -p "$(prompt_input "Disk Size [20G]: ")" DISK_SIZE; DISK_SIZE="${DISK_SIZE:-20G}"
    read -p "$(prompt_input "Memory MB [2048]: ")" MEMORY; MEMORY="${MEMORY:-2048}"
    read -p "$(prompt_input "CPUs [2]: ")" CPUS; CPUS="${CPUS:-2}"
    
    while true; do
        read -p "$(prompt_input "SSH Port [2222]: ")" SSH_PORT; SSH_PORT="${SSH_PORT:-2222}"
        if validate_input "port" "$SSH_PORT"; then
            if ss -tln 2>/dev/null | grep -q ":$SSH_PORT "; then print_status "ERROR" "Port in use"; else break; fi
        fi
    done

    read -p "$(prompt_input "GUI Mode (y/N) [n]: ")" gui_input; gui_input="${gui_input:-n}"
    if [[ "$gui_input" =~ ^[Yy]$ ]]; then GUI_MODE=true; else GUI_MODE=false; fi

    read -p "$(prompt_input "Port Forwards (e.g. 8080:80): ")" PORT_FORWARDS
    echo -e "  ${C}╰────────────────────────────────────────${NC}\n"

    IMG_FILE="$VM_DIR/$VM_NAME.img"
    SEED_FILE="$VM_DIR/$VM_NAME-seed.iso"
    CREATED="$(date)"

    setup_vm_image
    save_vm_config
    pause
}

setup_vm_image() {
    print_status "INFO" "Initializing Image Setup..."
    mkdir -p "$VM_DIR"
    
    if [[ -f "$IMG_FILE" ]]; then
        print_status "SUCCESS" "Image file already exists."
    else
        echo -e "  ${Y}⏳ Downloading OS Image...${NC}"
        if ! wget -q --show-progress "$IMG_URL" -O "$IMG_FILE.tmp"; then
            print_status "ERROR" "Failed to download image."
            exit 1
        fi
        mv "$IMG_FILE.tmp" "$IMG_FILE"
        print_status "SUCCESS" "Download Complete!"
    fi
    
    echo -e "  ${Y}⏳ Configuring virtual disk...${NC}"
    if ! qemu-img resize "$IMG_FILE" "$DISK_SIZE" >/dev/null 2>&1; then
        rm -f "$IMG_FILE"
        qemu-img create -f qcow2 -F qcow2 -b "$IMG_FILE" "$IMG_FILE.tmp" "$DISK_SIZE" >/dev/null 2>&1 || \
        qemu-img create -f qcow2 "$IMG_FILE" "$DISK_SIZE" >/dev/null 2>&1
        if [ -f "$IMG_FILE.tmp" ]; then mv "$IMG_FILE.tmp" "$IMG_FILE"; fi
    fi

    echo -e "  ${Y}⏳ Generating Cloud-Init configuration...${NC}"
    cat > user-data <<EOF
#cloud-config
hostname: $HOSTNAME
ssh_pwauth: true
disable_root: false
users:
  - name: $USERNAME
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    password: $(openssl passwd -6 "$PASSWORD" | tr -d '\n')
chpasswd:
  list: |
    root:$PASSWORD
    $USERNAME:$PASSWORD
  expire: false
EOF
    cat > meta-data <<EOF
instance-id: iid-$VM_NAME
local-hostname: $HOSTNAME
EOF

    if ! cloud-localds "$SEED_FILE" user-data meta-data >/dev/null 2>&1; then
        print_status "ERROR" "Failed to create cloud-init seed."
        exit 1
    fi
    
    echo -e "\n  ${G}🎉 VM '$VM_NAME' created successfully!${NC}"
    echo -e "  ${C}================================================${NC}"
    echo -e "  ${W}👤 Username :${NC} ${Y}$USERNAME${NC}"
    echo -e "  ${W}🔑 Password :${NC} ${DG}****${NC}"
    echo -e "  ${W}🔗 SSH Cmd  :${NC} ${C}ssh -p $SSH_PORT $USERNAME@localhost${NC}"
    echo -e "  ${C}================================================${NC}"
}

start_vm() {
    local vm_name=$1
    if load_vm_config "$vm_name"; then
        if ! check_image_lock "$IMG_FILE" "$vm_name"; then return 1; fi
        
        if is_vm_running "$vm_name"; then
            print_status "WARN" "VM is already running."
            return 1
        fi
        
        print_status "INFO" "Starting VM: ${W}$vm_name${NC}"
        print_status "INFO" "SSH Command: ${C}ssh -p $SSH_PORT $USERNAME@localhost${NC}"
        print_status "INFO" "🐌 Running in pure software emulation mode (No KVM)"
        
        local qemu_cmd=(
            qemu-system-x86_64 -m "$MEMORY" -smp "$CPUS" -cpu qemu64 -machine type=pc,accel=tcg
            -drive "file=$IMG_FILE,format=qcow2,if=virtio"
            -drive "file=$SEED_FILE,format=raw,if=virtio"
            -boot order=c -device virtio-net-pci,netdev=n0
            -netdev "user,id=n0,hostfwd=tcp::$SSH_PORT-:22"
        )

        if [[ -n "$PORT_FORWARDS" ]]; then
            IFS=',' read -ra forwards <<< "$PORT_FORWARDS"
            for forward in "${forwards[@]}"; do
                IFS=':' read -r host_port guest_port <<< "$forward"
                qemu_cmd+=(-device "virtio-net-pci,netdev=n${#qemu_cmd[@]}")
                qemu_cmd+=(-netdev "user,id=n${#qemu_cmd[@]},hostfwd=tcp::$host_port-:$guest_port")
            done
        fi

        if [[ "$GUI_MODE" == true ]]; then
            qemu_cmd+=(-vga virtio -display gtk,gl=on)
        else
            qemu_cmd+=(-nographic -serial mon:stdio)
            echo -e "  ${Y}💡 Tip: Press Ctrl+A then X to exit QEMU console.${NC}"
        fi

        qemu_cmd+=(-device virtio-balloon-pci -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -no-hpet -rtc base=utc,clock=host)

        if ! "${qemu_cmd[@]}"; then
            print_status "ERROR" "Failed to start VM."
            rm -f "${IMG_FILE}.lock" 2>/dev/null
            pause; return 1
        fi
        print_status "INFO" "VM $vm_name has been shut down."
        pause
    fi
}

delete_vm() {
    local vm_name=$1
    print_status "WARN" "This will permanently delete VM '$vm_name'!"
    read -p "$(echo -e "  ${R}╰─➤${NC} Are you sure? (y/N): ")" REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if load_vm_config "$vm_name"; then
            if is_vm_running "$vm_name"; then stop_vm "$vm_name" true; fi
            rm -f "$IMG_FILE" "$SEED_FILE" "$VM_DIR/$vm_name.conf" "${IMG_FILE}.lock" 2>/dev/null
            print_status "SUCCESS" "VM '$vm_name' deleted."
        fi
    fi
    pause
}

show_vm_info() {
    local vm_name=$1
    if load_vm_config "$vm_name"; then
        local state="${R}Stopped${NC}"
        if is_vm_running "$vm_name"; then state="${G}Running${NC}"; fi

        echo -e "\n  ${C}╭─[ 📊 VM INFORMATION ]${NC}"
        printf "  ${C}│${NC}  %-15s : %b\n" "Name" "${W}$vm_name${NC}"
        printf "  ${C}│${NC}  %-15s : %b\n" "Status" "$state"
        printf "  ${C}│${NC}  %-15s : %b\n" "OS" "${Y}$OS_TYPE${NC}"
        printf "  ${C}│${NC}  %-15s : %b\n" "Specs" "${W}${CPUS} Core, ${MEMORY}MB RAM, $DISK_SIZE${NC}"
        printf "  ${C}│${NC}  %-15s : %b\n" "SSH Port" "${C}$SSH_PORT${NC}"
        printf "  ${C}│${NC}  %-15s : %b\n" "Port Forwards" "${W}${PORT_FORWARDS:-None}${NC}"
        echo -e "  ${C}╰────────────────────────────────────────${NC}"
        pause
    fi
}

is_vm_running() {
    local vm_name=$1
    if pgrep -f "qemu-system.*$vm_name" >/dev/null; then return 0; fi
    if load_vm_config "$vm_name" 2>/dev/null; then
        if pgrep -f "qemu-system.*$IMG_FILE" >/dev/null; then return 0; fi
    fi
    return 1
}

stop_vm() {
    local vm_name=$1
    local silent=${2:-false}
    if load_vm_config "$vm_name"; then
        if is_vm_running "$vm_name"; then
            [ "$silent" = false ] && print_status "INFO" "Stopping VM..."
            pkill -f "qemu-system.*$IMG_FILE"; sleep 2
            if is_vm_running "$vm_name"; then pkill -9 -f "qemu-system.*$IMG_FILE"; fi
            rm -f "${IMG_FILE}.lock" 2>/dev/null
            [ "$silent" = false ] && print_status "SUCCESS" "VM stopped."
        else
            [ "$silent" = false ] && print_status "WARN" "VM is not running."
        fi
    fi
    [ "$silent" = false ] && pause
}

# ==========================================
# ⚙️ MAIN SYSTEM LOOP
# ==========================================

trap cleanup EXIT
check_dependencies

VM_DIR="${VM_DIR:-$HOME/vms}"
mkdir -p "$VM_DIR"

declare -A OS_OPTIONS=(
    ["Ubuntu 22.04"]="ubuntu|jammy|https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img|ubuntu22|ubuntu|ubuntu"
    ["Ubuntu 24.04"]="ubuntu|noble|https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img|ubuntu24|ubuntu|ubuntu"
    ["Debian 12"]="debian|bookworm|https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2|debian12|debian|debian"
    ["AlmaLinux 9"]="almalinux|9|https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2|almalinux9|alma|alma"
)

boot_sequence

while true; do
    show_dashboard
    
    local vms=($(get_vm_list))
    local vm_count=${#vms[@]}
    
    if [ $vm_count -gt 0 ]; then
        echo -e "  ${DG}╭─[ 🖥️  LOCAL VMs DETECTED ]${NC}"
        for i in "${!vms[@]}"; do
            local status="${R}● OFFLINE${NC}"
            if is_vm_running "${vms[$i]}"; then status="${G}● ONLINE ${NC}"; fi
            printf "  ${DG}│${NC}  ${P}[%d]${NC} %-25s %b\n" $((i+1)) "${vms[$i]}" "$status"
        done
        echo -e "  ${DG}╰────────────────────────────────────────${NC}\n"
    fi
    
    echo -e "  ${B}╭─[ ⚡ MENU OPTIONS ]${NC}"
    echo -e "  ${B}│${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}1${DG}]${NC} ${G}🆕 Create New VM${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}2${DG}]${NC} ${G}🚀 Start VM${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}3${DG}]${NC} ${Y}🛑 Stop VM${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}4${DG}]${NC} ${C}📊 Show VM Info${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}5${DG}]${NC} ${R}🗑️  Delete VM${NC}"
    echo -e "  ${B}│${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${R}0${DG}]${NC} ${DG}❌ Exit System${NC}"
    echo -e "  ${B}╰────────────────────────────────────────${NC}"
    echo ""
    
    read -p "$(echo -e "  ${B}╰─➤${NC} Select Option: ")" choice
    
    case $choice in
        1) create_new_vm ;;
        2) 
            if [ $vm_count -gt 0 ]; then
                read -p "$(echo -e "  ${G}╰─➤${NC} Enter VM number to START: ")" vm_num
                if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then start_vm "${vms[$((vm_num-1))]}"; fi
            fi ;;
        3) 
            if [ $vm_count -gt 0 ]; then
                read -p "$(echo -e "  ${Y}╰─➤${NC} Enter VM number to STOP: ")" vm_num
                if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then stop_vm "${vms[$((vm_num-1))]}"; fi
            fi ;;
        4) 
            if [ $vm_count -gt 0 ]; then
                read -p "$(echo -e "  ${C}╰─➤${NC} Enter VM number for INFO: ")" vm_num
                if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then show_vm_info "${vms[$((vm_num-1))]}"; fi
            fi ;;
        5) 
            if [ $vm_count -gt 0 ]; then
                read -p "$(echo -e "  ${R}╰─➤${NC} Enter VM number to DELETE: ")" vm_num
                if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then delete_vm "${vms[$((vm_num-1))]}"; fi
            fi ;;
        0) 
            echo -e "\n  ${R}[SYS] Terminating processes...${NC}"
            sleep 0.5; echo -e "  ${DG}[SYS] Goodbye!${NC}\n"
            exit 0 ;;
        *) print_status "ERROR" "Invalid option"; sleep 1 ;;
    esac
done

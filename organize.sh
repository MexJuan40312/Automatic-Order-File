#!/bin/bash
#
#  OrderFileScript v2.1 - The stylish file organizer.
#  Moves files into folders based on their extension.
#

# --- Configuration ---
TARGET_DIR="/home/juanr/Downloads"

# --- Terminal Colors ---
GREEN='\033[0;32m'   # Green
YELLOW='\033[1;33m'  # Yellow
NC='\033[0m'         # No Color (to reset)

# --- ASCII Art Banner ---
clear # Clears the screen for a bigger impact
cat << "EOF"

       ____             __   ____    _     __         
      / __ \____ ______/ /__/ __/___(_)___/ /___ _____
     / / / / __ `/ ___/ //_/ /_/ __ \/ __  / __ `/ __ \
    / /_/ / /_/ / /__/ ,< / __/ /_/ / /_/ / /_/ / / / /
   /_____/\__,_/\___/_/|_/_/  \____/\__,_/\__,_/_/ /_/ 
                                                     
EOF

echo -e "${YELLOW}Starting organization in: ${NC}$TARGET_DIR"
echo "--------------------------------------------------------"
sleep 1 # A little pause for dramatic effect

# --- Organization Logic ---

# Create destination directories if they don't exist.
echo -e "${YELLOW}-> Checking destination folders...${NC}"
mkdir -p "$TARGET_DIR/Images"
mkdir -p "$TARGET_DIR/Documents"
mkdir -p "$TARGET_DIR/Videos"
mkdir -p "$TARGET_DIR/Music"
mkdir -p "$TARGET_DIR/Compressed"
mkdir -p "$TARGET_DIR/Others"
sleep 0.5

# Main loop to go through and move each file.
find "$TARGET_DIR" -maxdepth 1 -type f | while read file; do
    # Extract just the filename for cleaner output
    filename=$(basename "$file")

    case "${file##*.}" in
        # Image extensions
        jpg|jpeg|png|gif|bmp|svg|webp)
            mv "$file" "$TARGET_DIR/Images/"
            echo -e "${GREEN}[+] Moved (Image):${NC} $filename"
            ;;
        # Document extensions
        pdf|doc|docx|txt|odt|xls|xlsx|ppt|pptx)
            mv "$file" "$TARGET_DIR/Documents/"
            echo -e "${GREEN}[+] Moved (Document):${NC} $filename"
            ;;
        # Video extensions
        mp4|mov|avi|mkv|wmv|flv)
            mv "$file" "$TARGET_DIR/Videos/"
            echo -e "${GREEN}[+] Moved (Video):${NC} $filename"
            ;;
        # Music extensions
        mp3|wav|ogg|flac|aac)
            mv "$file" "$TARGET_DIR/Music/"
            echo -e "${GREEN}[+] Moved (Music):${NC} $filename"
            ;;
        # Compressed file extensions
        zip|rar|7z|tar|gz|bz2)
            mv "$file" "$TARGET_DIR/Compressed/"
            echo -e "${GREEN}[+] Moved (Compressed):${NC} $filename"
            ;;
        # Anything else goes to "Others"
        *)
            # Avoid the script moving itself
            if [ "$filename" != "organize.sh" ]; then
                mv "$file" "$TARGET_DIR/Others/"
                echo -e "${GREEN}[+] Moved (Other):${NC} $filename"
            fi
            ;;
    esac
done

echo "--------------------------------------------------------"
echo -e "${GREEN}--> Organization completed successfully!${NC}"
echo ""

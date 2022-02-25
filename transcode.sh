#!/bin/bash

Path_2="/root/"  # 这里输入要批量转码的地址

SAVEIFS=${IFS};
echo -n "$IFS" | hexdump

IFS=$'\n';
echo -n "$IFS" | hexdump

echo "开始视频转码"
for  file_2 in $(find ${Path_2} -name "*.avi" -o -name "*.wmv" -o -name "*.mp4" -o -name "*.rmvb" -o -name "*.flv" -o -name "*.3gp")  # 这里填要查找的视频后缀
do
    echo -n "$IFS" | hexdump
    echo "正在处理: ${file_2}"
    file_2name=$(basename ${file_2})
    echo "文件: ${file_2name}"
    file_2Dirname=$(dirname ${file_2})
    echo "路径: ${file_2Dirname}"
    file_2Extension=${file_2name##*.}
    echo "扩展名: ${file_2Extension}"
    file_2BasenameNoExtension=${file_2name%.*}
    echo "文件名: ${file_2BasenameNoExtension}"

    if hash ffmpeg 2>/dev/null
    then
        echo "正在转码: ${file_2}"
        echo -n "$IFS" | hexdump
        ffmpeg -i "${file_2}" -pix_fmt yuv420p "${file_2Dirname}/${file_2BasenameNoExtension}.mkv" -y   # 这里填转码输出文件后缀和转码参数
        echo "${file_2} 转码完成"
        echo -n "$IFS" | hexdump

        if test -e "${file_2Dirname}/${file_2BasenameNoExtension}.mkv"   # 同上，同步改后缀
        then 
            rm -rf "${file_2}"
                echo "已删除原视频"
        fi
    echo -n "$IFS" | hexdump
    fi
done;

IFS=${SAVEIFS}
echo -n "$IFS" | hexdump
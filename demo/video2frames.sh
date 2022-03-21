IN_DATA_DIR=$1 #这里传入输入视频的路径
OUT_DATA_DIR=$2 #这里传入输出视频的路径
#IN_DATA_DIR="../../data/ava/videos_15min"
#OUT_DATA_DIR="../../data/ava/frames"

if [[ ! -d "${OUT_DATA_DIR}" ]]; then
  echo "${OUT_DATA_DIR} doesn't exist. Creating it.";
  mkdir -p ${OUT_DATA_DIR}
fi

for video in $(ls -A1 -U ${IN_DATA_DIR}/*)
do
  video_name=${video##*/}

  if [[ $video_name = *".webm" ]]; then
    video_name=${video_name::-5}
  else
    video_name=${video_name::-4}
  fi

  out_video_dir=${OUT_DATA_DIR}/${video_name}/
  mkdir -p "${out_video_dir}"

  out_name="${out_video_dir}/${video_name}_%05d.jpg"

  ffmpeg -i "${video}" -r 30 -q:v 1 "${out_name}"
done

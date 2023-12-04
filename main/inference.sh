#!/usr/bin/env bash
set -x

INPUT_VIDEO=$1
FORMAT=$2
FPS=$3
CKPT=$4

JOB_NAME=inference_${INPUT_VIDEO}

IMG_PATH=../demo/images/${INPUT_VIDEO}
SAVE_DIR=../demo/results/${INPUT_VIDEO}

# video to images
mkdir -p $IMG_PATH
mkdir -p $SAVE_DIR
ffmpeg -i ../demo/videos/${INPUT_VIDEO}.${FORMAT} -f image2 -vf fps=${FPS}/1 -qscale 0 ../demo/images/${INPUT_VIDEO}/%06d.jpg 

end_count=$(find "$IMG_PATH" -type f | wc -l)
echo $end_count

# inference
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python inference.py \
--num_gpus 1 \
--exp_name output/demo_${JOB_NAME} \
--pretrained_model ${CKPT} \
--agora_benchmark agora_model \
--img_path ${IMG_PATH} \
--start 1 \
--end  $end_count \
--output_folder ${SAVE_DIR} \
--show_bbox \
--save_mesh \
# --multi_person \
# --iou_thr 0.2 \
# --bbox_thr 20


# images to video
ffmpeg -y -f image2 -r ${FPS} -i ${SAVE_DIR}/img/%06d.jpg -c:v libx264 -pix_fmt yuvj420p ../demo/results/${INPUT_VIDEO}.mp4

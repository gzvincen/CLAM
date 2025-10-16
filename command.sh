#TODO 一些本地运行命令的记录

# 提取 patch
python create_patches_fp.py --source /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/wsis --save_dir /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/results --patch_size 256 --step_size 256 --seg --patch --stitch

# 跑特征数据，本地当时用的 resnet50_trunc, 没有用 uni_v1 跑，因为太耗时
python extract_features_fp.py --data_h5_dir /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/results --data_slide_dir /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/wsis --csv_path /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/results/process_list_autogen.csv --feat_dir /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/results --target_patch_size 256 --slide_ext .svs --model_name uni_v1

# 分组数据，准备训练
python create_splits_seq.py --task task_1_tumor_vs_normal --seed 42 --k 1

# 训练数据，得输出 s_0_checkpoint.pt 后才能跑 heatmap
python main.py --drop_out 0.25 --lr 2e-4 --k 1 --exp_code task1_ccrcc_1015 --weighted_sample --bag_loss ce --inst_loss svm --task task_1_tumor_vs_normal --model_type clam_sb --log_data --data_root_dir /Users/gaozhen/d_pan/Documents/source_code/CLAM/dataset_ccrcc/results --embed_dim 1024

# 跑 heatmap，注意修改 yaml 的内容
python create_heatmaps.py --config config_template_ccrcc.yaml


备注：文件目录结构，以及用到的 svs 文件
dataset_ccrcc
├── results
└── wsis
    ├── C3L-00011-21.svs
    ├── C3L-00079-21.svs
    ├── C3L-00097-21.svs
    ├── C3L-00097-26.svs
    ├── C3L-00103-22.svs
    ├── C3L-00103-23.svs
    ├── C3L-00165-26.svs
    ├── C3L-00183-21.svs
    ├── C3L-00183-22.svs
    ├── C3L-00183-23.svs
    ├── C3L-00183-24.svs
    ├── C3L-00183-25.svs
    ├── C3L-00183-26.svs
    ├── C3L-00360-21.svs
    ├── C3L-00360-22.svs
    ├── C3L-00369-23.svs
    ├── C3L-00369-26.svs
    ├── C3L-00416-26.svs
    ├── C3L-00447-22.svs
    ├── C3L-00447-23.svs
    ├── non_C3L-01458-21.svs
    ├── non_C3L-01460-21.svs
    ├── non_C3L-01467-21.svs
    ├── non_C3L-01558-21.svs
    ├── non_C3L-01865-21.svs
    ├── non_C3L-01865-22.svs
    ├── non_C3L-01865-23.svs
    ├── non_C3L-01865-26.svs
    ├── non_C3L-01953-21.svs
    ├── non_C3L-02210-22.svs
    ├── non_C3N-01177-23.svs
    ├── non_C3N-01362-28.svs
    ├── non_C3N-01362-30.svs
    └── non_C3N-01650-30.svs

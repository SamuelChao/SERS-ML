CREATE DATABASE IF NOT EXISTS `SERS_ML_TEST`;
USE `SERS_ML_TEST`;

CREATE TABLE IF NOT EXISTS `Lab_Groups`(
    `id` INT AUTO_INCREMENT,
    `file_name` TEXT,
    `bacteria` VARCHAR(64),
    `strain` VARCHAR(32),
    `subtype` VARCHAR(32),
    `antibiotic` VARCHAR(32),
    `anti_conc` VARCHAR(32),
    `anti_time` VARCHAR(32),
    `data_type` VARCHAR(32) DEFAULT 'dataset',
    `data_path` TEXT NOT NULL,
    `wvn_range` VARCHAR(32),
    `wvn_lb` DECIMAL(5,1),
    `wvn_hb` DECIMAL(5,1),
    `wvn_distant` DECIMAL(5,1),    
    `count` INT,
    
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `Lab_Groups_Statistic`(
    `id` INT AUTO_INCREMENT,
    `file_name` TEXT,
    `lab_group_id` INT,
    `data_type` VARCHAR(32),
    `data_path` TEXT NOT NULL,
    
    PRIMARY KEY(`id`),
    FOREIGN KEY(`lab_group_id`) REFERENCES `Lab_Groups`(`id`)
);

CREATE TABLE IF NOT EXISTS `Combine_SERS`(
    `id` INT AUTO_INCREMENT,
    `file_name` TEXT,
    `bacteria_set_id` VARCHAR(64),
    `strain_set_id` VARCHAR(32),
    `subtype_set_id` VARCHAR(32),
    `antibiotic` VARCHAR(32),
    `anti_conc` VARCHAR(32),
    `anti_time` VARCHAR(32),
    `data_type` VARCHAR(32) DEFAULT 'dataset',
    `data_path` TEXT NOT NULL,
    `count` INT,
    `wvn_range` VARCHAR(32),
    `wvn_lb` DECIMAL(5,1),
    `wvn_hb` DECIMAL(5,1),
    `wvn_distant` DECIMAL(5,1) DEFAULT 0.5, 
    
    
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `Combine_Groups`(
    `id` INT AUTO_INCREMENT,
    `combine_id` INT,
    `lab_group_id` INT,
    
    PRIMARY KEY(`id`),
    FOREIGN KEY(`combine_id`) REFERENCES `Combine_SERS`(`id`),
    FOREIGN KEY(`lab_group_id`) REFERENCES `Lab_Groups`(`id`)   
);   

CREATE TABLE IF NOT EXISTS `Combine_SERS_Statistic`(
    `id` INT AUTO_INCREMENT,
    `file_name` TEXT,
    `combine_id` INT,
    `data_type` VARCHAR(32),
    `data_path` TEXT NOT NULL,
    
    PRIMARY KEY(`id`),
    FOREIGN KEY(`combine_id`) REFERENCES `Combine_SERS`(`id`)
);

CREATE TABLE IF NOT EXISTS `Preprocess_SERS`(
    `id` INT AUTO_INCREMENT,
    `file_name` TEXT,
    `bacteria_set_id` VARCHAR(64),
    `strain_set_id` VARCHAR(32),
    `subtype_set_id` VARCHAR(32),
    `antibiotic` VARCHAR(32),
    `anti_conc` VARCHAR(32),
    `anti_time` VARCHAR(32),
    `data_type` VARCHAR(32),
    `data_path` TEXT NOT NULL,
    `count` INT,
    `wvn_range` VARCHAR(32),
    `wvn_lb` DECIMAL(5,1),
    `wvn_hb` DECIMAL(5,1),
    `wvn_distant` DECIMAL(5,1) DEFAULT 0.5,  
    
    `combine_id` INT,    
    `normalized` TINYINT(1) DEFAULT 0,
    `cleaned` TINYINT(1) DEFAULT 0,
    `labeled` TINYINT(1) DEFAULT 0,
    
    `train` TINYINT(1) DEFAULT 0,
    `test`  TINYINT(1) DEFAULT 0,
    
    
    PRIMARY KEY(`id`),
    FOREIGN KEY(`combine_id`) REFERENCES `Combine_SERS`(`id`)
);

CREATE TABLE IF NOT EXISTS `Preprocess_SERS_Statistic`(
    `id` INT AUTO_INCREMENT,
    `file_name` TEXT,
    `preprocess_id` INT,
    `data_type` VARCHAR(32),
    `data_path` TEXT NOT NULL,
    
    PRIMARY KEY(`id`),
    FOREIGN KEY(`preprocess_id`) REFERENCES `Preprocess_SERS`(`id`)
);

CREATE TABLE IF NOT EXISTS `Visualize_Methods`(
    `id` INT AUTO_INCREMENT,
    `method` VARCHAR(32),
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `Data_Visualization`(
    `id` INT AUTO_INCREMENT,
    `method` VARCHAR(32),
    `method_id` INT,
    `dataset_id` INT,
    `dataset_path` TEXT,
    `method_parameters_id` INT,
    `normalized` TINYINT(1),
    `result_path` TEXT,
    `figure_path` TEXT NOT NULL,

    PRIMARY KEY(`id`),    
    FOREIGN KEY(`method_id`) REFERENCES `Visualize_Methods`(`id`),
    FOREIGN KEY(`dataset_id`) REFERENCES `Preprocess_SERS`(`id`)
);

CREATE TABLE IF NOT EXISTS `PCA`(
    `id` INT AUTO_INCREMENT,
    `n-component` INT,
    `font_size` INT DEFAULT 6,
    `figure_dpi` INT DEFAULT 300,
    `wvn_range` VARCHAR(32) DEFAULT '400.0 : 1550.0',
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `T-SNE`(
    `id` INT AUTO_INCREMENT,
    `n-component` INT,
    `init` VARCHAR(32),
    `learning_rate` DECIMAL(10,10),
    `perplexity` INT,
    `font_size` INT DEFAULT 6,
    `figure_dpi` INT DEFAULT 300,
    `wvn_range` VARCHAR(32) DEFAULT '400.0 : 1550.0',
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `Visual_Labels`(
    `id` INT,
    -- `id` INT AUTO_INCREMENT,
    `label` VARCHAR(32),
    `color_map` VARCHAR(32),
    `marker_list` VARCHAR(8),
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `ML_methods`(
    `id` INT AUTO_INCREMENT,
    `method` VARCHAR(32),
    `method_fullname` TEXT,
    
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `Machine_Learning`(
    `id` INT AUTO_INCREMENT,
    `method` VARCHAR(32),
    `ML_method_id` INT,
    `method_parameters_id` INT,
    `dataset_id` INT,
    `train_set_id` INT,
    `train_set_path` TEXT,
    `train_size` INT,
    `test_set_id` INT,
    `test_size` INT,
    `test_set_path` TEXT,
    `training_log` TEXT,
    `prediction_path` TEXT,
    `accuracy` DECIMAL(5,2),
    `confusion_matrix_path` TEXT,
    `confusion_matrix_figure` TEXT,
    `other_conditions` TEXT,
    
     
     PRIMARY KEY(`id`),
     FOREIGN KEY(`ML_method_id`) REFERENCES `ML_methods`(`id`),
     FOREIGN KEY(`dataset_id`) REFERENCES `Preprocess_SERS`(`id`),
     FOREIGN KEY(`train_set_id`) REFERENCES `Preprocess_SERS`(`id`),
     FOREIGN KEY(`test_set_id`) REFERENCES `Preprocess_SERS`(`id`)
);

CREATE TABLE IF NOT EXISTS `RF`(
    `id` INT AUTO_INCREMENT,
    `max_depth` INT,
    `max_samples` DECIMAL(5,5) ,
    `min_samples_split` INT,
    `random_state` INT,
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `SVM`(
    `id` INT AUTO_INCREMENT,
    `C` INT,
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `KNN`(
    `id` INT AUTO_INCREMENT,
    `algorithm` VARCHAR(64),
    `n_neighbors` INT,
    `weight` VARCHAR(64),
    
    PRIMARY KEY(`id`)   
);

CREATE TABLE IF NOT EXISTS `CNN`(
    `id` INT AUTO_INCREMENT,
    `epoch` INT,
    `batch_size` INT,
    `learning_rate` DECIMAL(10,10),
    `wd` DECIMAL(10,10),
    `random_seed` INT,
    `model_code_path` TEXT,
    `model_path` TEXT,
    `learning_curve_path` TEXT,
    `loss_record_path` TEXT,
    `accuracy_record_path` TEXT,
    `file_path` TEXT,
    
    PRIMARY KEY(`id`)   
);
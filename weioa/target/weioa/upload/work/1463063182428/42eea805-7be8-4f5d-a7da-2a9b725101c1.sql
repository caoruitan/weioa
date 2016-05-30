SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS  `libra_db_history`;
CREATE TABLE `libra_db_history` (
  `version` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `run_on` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_db_version`;
CREATE TABLE `libra_db_version` (
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `revinfo`;
CREATE TABLE `revinfo` (
  `rev` int(11) NOT NULL AUTO_INCREMENT,
  `revtstmp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`rev`)
) ENGINE=InnoDB AUTO_INCREMENT=96438 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `craft_deleted_vod_file`;
CREATE TABLE `craft_deleted_vod_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(1024) NOT NULL,
  `thumbnail` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43172 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `craft_user_vod_favorite`;
CREATE TABLE `craft_user_vod_favorite` (
  `user_profile_id` bigint(20) NOT NULL,
  `vod_metadata_id` bigint(20) NOT NULL,
  `public_id` varchar(191) DEFAULT NULL,
  `display_name` varchar(128) DEFAULT '',
  `play_count` int(11) DEFAULT '0',
  `add_timestamp` bigint(20) DEFAULT '0',
  `open_to_circle` int(11) DEFAULT '0',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_user_vod_favorite_unique_user_vod` (`user_profile_id`,`vod_metadata_id`),
  UNIQUE KEY `craft_user_vod_favorite_public_id_key` (`public_id`),
  KEY `index_craft_vod_file_public_id` (`public_id`),
  KEY `craft_user_vod_favorite_vod_metadata_id_fkey` (`vod_metadata_id`),
  CONSTRAINT `craft_user_vod_favorite_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `craft_user_vod_favorite_vod_metadata_id_fkey` FOREIGN KEY (`vod_metadata_id`) REFERENCES `libra_vod_metadata` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30761 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `craft_vod_file`;
CREATE TABLE `craft_vod_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(1024) NOT NULL,
  `thumbnail` varchar(1024) NOT NULL,
  `file_size` bigint(20) DEFAULT '1048576',
  PRIMARY KEY (`id`),
  KEY `index_craft_vod_file_name` (`file_name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=153278 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `craft_vod_file_ex`;
CREATE TABLE `craft_vod_file_ex` (
  `id` varchar(32) NOT NULL,
  `file_name` varchar(1024) NOT NULL,
  `thumbnail` varchar(1024) NOT NULL,
  `file_size` bigint(20) DEFAULT '1048576',
  PRIMARY KEY (`id`),
  KEY `index_craft_vod_file_name` (`file_name`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `external_vod_metadata`;
CREATE TABLE `external_vod_metadata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recording_id` varchar(256) NOT NULL,
  `seq_id` int(11) NOT NULL,
  `end_tag` int(11) DEFAULT '0',
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NOT NULL,
  `duration` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `state` smallint(6) DEFAULT NULL,
  `arrival_timestamp` bigint(20) DEFAULT NULL,
  `vod_file_id` bigint(20) DEFAULT NULL,
  `crypto_key` varchar(256) DEFAULT 'nocryptokey',
  `removed_on_nemo` int(11) DEFAULT '0',
  `extratype` varchar(100) DEFAULT NULL,
  `extra_content` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_abandoned_magic_number`;
CREATE TABLE `libra_abandoned_magic_number` (
  `id` varchar(32) NOT NULL,
  `magic_number` varchar(20) DEFAULT NULL,
  `last_abandoned_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_abandoned_magic_number_magic_number_key` (`magic_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_abandoned_magic_number_aud`;
CREATE TABLE `libra_abandoned_magic_number_aud` (
  `id` varchar(32) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `magic_number` varchar(20) DEFAULT NULL,
  `last_abandoned_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_abandoned_magic_number_aud_fkey` (`rev`),
  CONSTRAINT `libra_abandoned_magic_number_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_album`;
CREATE TABLE `libra_album` (
  `id` varchar(64) NOT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_album_item`;
CREATE TABLE `libra_album_item` (
  `id` varchar(64) NOT NULL,
  `album_id` varchar(64) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `channel` varchar(32) DEFAULT NULL,
  `display_name` varchar(256) DEFAULT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  `upload_timestamp` bigint(20) DEFAULT NULL,
  `oss_key` varchar(256) DEFAULT NULL,
  `thumbnail_oss_key` varchar(256) DEFAULT NULL,
  `decrypt_algorithm` varchar(2048) DEFAULT 'CLEAR_TEXT',
  `decrypt_key` varchar(2048) DEFAULT '',
  `record_id` varchar(512) NOT NULL,
  `size` bigint(20) DEFAULT '0',
  `thumbnail_size` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `libra_album_item_album_id_fkey` (`album_id`),
  KEY `libra_album_item_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_album_item_album_id_fkey` FOREIGN KEY (`album_id`) REFERENCES `libra_album` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_album_item_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_ali_video`;
CREATE TABLE `libra_ali_video` (
  `id` varchar(32) NOT NULL,
  `action` varchar(20) DEFAULT NULL,
  `app` varchar(128) DEFAULT NULL,
  `appname` varchar(128) DEFAULT NULL,
  `stream_id` varchar(32) DEFAULT NULL,
  `node` varchar(128) DEFAULT NULL,
  `ip` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_authority_rule_nemo`;
CREATE TABLE `libra_authority_rule_nemo` (
  `id` varchar(32) NOT NULL,
  `community_nemo_id` varchar(32) DEFAULT NULL,
  `auth_name` varchar(64) DEFAULT NULL,
  `auth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_authority_rule_nemo_community_nemo_id_fkey` (`community_nemo_id`),
  CONSTRAINT `libra_authority_rule_nemo_community_nemo_id_fkey` FOREIGN KEY (`community_nemo_id`) REFERENCES `libra_community_nemo` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_authority_rule_nemo_aud`;
CREATE TABLE `libra_authority_rule_nemo_aud` (
  `id` varchar(32) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `community_nemo_id` varchar(32) DEFAULT NULL,
  `auth_name` varchar(64) DEFAULT NULL,
  `auth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_authority_rule_nemo_aud_community_nemo_id_fkey` (`community_nemo_id`),
  KEY `libra_authority_rule_nemo_aud_fkey` (`rev`),
  CONSTRAINT `libra_authority_rule_nemo_aud_community_nemo_id_fkey` FOREIGN KEY (`community_nemo_id`) REFERENCES `libra_community_nemo` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_authority_rule_nemo_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_authority_rule_user`;
CREATE TABLE `libra_authority_rule_user` (
  `id` varchar(32) NOT NULL,
  `community_user_id` varchar(32) DEFAULT NULL,
  `auth_name` varchar(64) DEFAULT NULL,
  `auth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_authority_rule_user_community_user_id_fkey` (`community_user_id`),
  CONSTRAINT `libra_authority_rule_user_community_user_id_fkey` FOREIGN KEY (`community_user_id`) REFERENCES `libra_community_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_authority_rule_user_aud`;
CREATE TABLE `libra_authority_rule_user_aud` (
  `id` varchar(32) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `community_user_id` varchar(32) DEFAULT NULL,
  `auth_name` varchar(64) DEFAULT NULL,
  `auth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_authority_rule_user_aud_community_user_id_fkey` (`community_user_id`),
  KEY `libra_authority_rule_user_aud_fkey` (`rev`),
  CONSTRAINT `libra_authority_rule_user_aud_community_user_id_fkey` FOREIGN KEY (`community_user_id`) REFERENCES `libra_community_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_authority_rule_user_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_black_account`;
CREATE TABLE `libra_black_account` (
  `id` varchar(64) NOT NULL,
  `created_timestamp` bigint(20) DEFAULT NULL,
  `created_reason` varchar(256) DEFAULT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_black_account_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_black_account_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_charge_resource_config`;
CREATE TABLE `libra_charge_resource_config` (
  `id` varchar(32) NOT NULL,
  `identifier` varchar(32) DEFAULT NULL,
  `identifier_type` smallint(6) DEFAULT NULL,
  `profile_type` smallint(6) DEFAULT NULL,
  `config_name` varchar(32) DEFAULT NULL,
  `config_value` varchar(1024) DEFAULT NULL,
  `config_expire_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_charge_resource_record`;
CREATE TABLE `libra_charge_resource_record` (
  `id` varchar(32) NOT NULL,
  `serial_number` varchar(32) NOT NULL,
  `nemo_sn` varchar(128) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  `resource_type` smallint(6) DEFAULT '0',
  `record_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_community_nemo`;
CREATE TABLE `libra_community_nemo` (
  `community_of_one_nemo_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `id` varchar(32) NOT NULL,
  `create_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_community_nemo_id_key` (`id`),
  UNIQUE KEY `libra_community_nemo_unique` (`community_of_one_nemo_id`,`nemo_id`),
  KEY `libra_community_nemo_nemo_id_fkey` (`nemo_id`),
  CONSTRAINT `libra_community_nemo_community_of_one_nemo_id_fkey` FOREIGN KEY (`community_of_one_nemo_id`) REFERENCES `libra_community_of_one_nemo` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_community_nemo_nemo_id_fkey` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_community_nemo_aud`;
CREATE TABLE `libra_community_nemo_aud` (
  `id` varchar(32) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `community_of_one_nemo_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `create_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_community_nemo_aud_fkey` (`rev`),
  CONSTRAINT `libra_community_nemo_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_community_of_one_nemo`;
CREATE TABLE `libra_community_of_one_nemo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nemo_id` bigint(20) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_community_of_one_nemo_nemo_id_key` (`nemo_id`),
  KEY `libra_community_of_one_nemo_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_community_of_one_nemo_nemo_id_fkey` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_community_of_one_nemo_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8554 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_community_user`;
CREATE TABLE `libra_community_user` (
  `community_of_one_nemo_id` bigint(20) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `id` varchar(32) NOT NULL,
  `create_timestamp` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_community_user_id_key` (`id`),
  UNIQUE KEY `libra_community_user_unique` (`community_of_one_nemo_id`,`user_profile_id`),
  KEY `libra_community_user_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_community_user_community_of_one_nemo_id_fkey` FOREIGN KEY (`community_of_one_nemo_id`) REFERENCES `libra_community_of_one_nemo` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_community_user_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_community_user_aud`;
CREATE TABLE `libra_community_user_aud` (
  `id` varchar(32) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `community_of_one_nemo_id` bigint(20) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `create_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_community_user_aud_fkey` (`rev`),
  CONSTRAINT `libra_community_user_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_conference_manage_config`;
CREATE TABLE `libra_conference_manage_config` (
  `id` varchar(32) NOT NULL,
  `config_name` varchar(128) NOT NULL,
  `config_value` varchar(512) DEFAULT NULL,
  `conference_number_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_conference_number`;
CREATE TABLE `libra_conference_number` (
  `id` varchar(32) NOT NULL,
  `number` varchar(30) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `enabled` smallint(6) DEFAULT '0',
  `display_name` varchar(256) DEFAULT NULL,
  `meeting_control_password` varchar(20) DEFAULT NULL,
  `auto_mute` smallint(6) DEFAULT '0',
  `chief_model` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_conference_number_share`;
CREATE TABLE `libra_conference_number_share` (
  `id` varchar(32) NOT NULL,
  `conference_number_id` varchar(32) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  `share_code` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `share_code` (`share_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_customize_feature`;
CREATE TABLE `libra_customize_feature` (
  `id` varchar(32) NOT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `icon` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `feature_type` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `nemo_number` varchar(20) DEFAULT NULL,
  `source_type` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `description` varchar(1024) DEFAULT NULL,
  `client_version` int(11) DEFAULT NULL,
  `name_key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_default_config`;
CREATE TABLE `libra_default_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `config_name` varchar(32) DEFAULT NULL,
  `config_value` varchar(128) DEFAULT NULL,
  `config_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_default_resource_count`;
CREATE TABLE `libra_default_resource_count` (
  `id` varchar(32) NOT NULL,
  `resource_name` varchar(30) NOT NULL,
  `default_count` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_device_black_list`;
CREATE TABLE `libra_device_black_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_identifier_id` varchar(128) DEFAULT NULL,
  `device_sn` varchar(128) DEFAULT NULL,
  `operation_type` smallint(6) NOT NULL,
  `operation_timestamp` bigint(20) NOT NULL,
  `always` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_charge_resource`;
CREATE TABLE `libra_enterprise_charge_resource` (
  `id` varchar(32) NOT NULL,
  `resource_type` smallint(6) DEFAULT NULL,
  `qualification` smallint(6) DEFAULT NULL,
  `charge_id` varchar(32) DEFAULT NULL,
  `balance` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_charge_resource_record`;
CREATE TABLE `libra_enterprise_charge_resource_record` (
  `id` varchar(32) NOT NULL,
  `serial_number` varchar(32) DEFAULT NULL,
  `resource_type` smallint(6) DEFAULT NULL,
  `qualification` smallint(6) DEFAULT NULL,
  `charge_id` varchar(32) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  `record_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_nemo`;
CREATE TABLE `libra_enterprise_nemo` (
  `id` varchar(32) NOT NULL,
  `nemo_sn` varchar(128) NOT NULL,
  `enterprise_profile_id` varchar(32) DEFAULT NULL,
  `conference_number_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nemo_sn` (`nemo_sn`),
  UNIQUE KEY `conference_number_id` (`conference_number_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_nemo_config`;
CREATE TABLE `libra_enterprise_nemo_config` (
  `id` varchar(32) NOT NULL,
  `config_name` varchar(32) NOT NULL,
  `config_value` varchar(1024) DEFAULT NULL,
  `enterprise_profile_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_nemo_config_aud`;
CREATE TABLE `libra_enterprise_nemo_config_aud` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `rev` int(11) NOT NULL DEFAULT '0',
  `revtype` smallint(6) DEFAULT NULL,
  `config_name` varchar(32) DEFAULT NULL,
  `config_value` varchar(1024) DEFAULT NULL,
  `enterprise_profile_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_nemo_feature`;
CREATE TABLE `libra_enterprise_nemo_feature` (
  `id` varchar(32) NOT NULL,
  `feature_id` varchar(32) NOT NULL,
  `feature_status` tinyint(4) DEFAULT NULL,
  `enterprise_profile_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_nemo_feature_aud`;
CREATE TABLE `libra_enterprise_nemo_feature_aud` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `rev` int(11) NOT NULL DEFAULT '0',
  `revtype` smallint(6) DEFAULT NULL,
  `feature_id` varchar(32) DEFAULT NULL,
  `feature_status` tinyint(4) DEFAULT NULL,
  `enterprise_profile_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_nemo_profile`;
CREATE TABLE `libra_enterprise_nemo_profile` (
  `id` varchar(32) NOT NULL,
  `display_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_session_resource`;
CREATE TABLE `libra_enterprise_session_resource` (
  `id` varchar(32) NOT NULL,
  `charge_id` varchar(32) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  `begin_time` bigint(20) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_session_resource_record`;
CREATE TABLE `libra_enterprise_session_resource_record` (
  `id` varchar(32) NOT NULL,
  `serial_number` varchar(32) DEFAULT NULL,
  `charge_id` varchar(32) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  `begin_time` bigint(20) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  `record_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_enterprise_special_contacts`;
CREATE TABLE `libra_enterprise_special_contacts` (
  `id` varchar(32) NOT NULL,
  `special_contact_id` varchar(32) NOT NULL,
  `enterprise_profile_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_event`;
CREATE TABLE `libra_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `user_device_id` varchar(1024) DEFAULT NULL,
  `event_type` int(11) NOT NULL,
  `event_content` varchar(4096) DEFAULT NULL,
  `event_additional` varchar(4096) DEFAULT NULL,
  `event_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_event_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_event_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2969563 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_ext_nemo_bind_code`;
CREATE TABLE `libra_ext_nemo_bind_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bind_code` varchar(32) NOT NULL,
  `device_sn` varchar(128) NOT NULL,
  `expire_time` bigint(20) DEFAULT '9223372036854775807',
  `in_use` int(11) DEFAULT '1',
  `extra` varchar(10) DEFAULT NULL,
  `fingerprint` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=657 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_hardware_device`;
CREATE TABLE `libra_hardware_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(30) NOT NULL,
  `bind_code` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_hardware_device_serial_number_key` (`serial_number`),
  UNIQUE KEY `libra_hardware_device_bind_code_key` (`bind_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_live_video`;
CREATE TABLE `libra_live_video` (
  `id` varchar(32) NOT NULL,
  `time_start` bigint(20) DEFAULT NULL,
  `time_end` bigint(20) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `detail` text,
  `pic` varchar(256) DEFAULT NULL,
  `push_url` varchar(256) DEFAULT NULL,
  `video_rtmp` varchar(256) DEFAULT NULL,
  `video_flv` varchar(256) DEFAULT NULL,
  `video_m3u8` varchar(256) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `conf_no` varchar(30) DEFAULT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  `nemo_id` bigint(20) NOT NULL,
  `version` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_profile_id` (`user_profile_id`),
  UNIQUE KEY `nemo_id` (`nemo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_live_video_aud`;
CREATE TABLE `libra_live_video_aud` (
  `id` varchar(32) DEFAULT NULL,
  `rev` int(11) DEFAULT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `time_start` bigint(20) DEFAULT NULL,
  `time_end` bigint(20) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `detail` text,
  `pic` varchar(256) DEFAULT NULL,
  `push_url` varchar(256) DEFAULT NULL,
  `video_rtmp` varchar(256) DEFAULT NULL,
  `video_flv` varchar(256) DEFAULT NULL,
  `video_m3u8` varchar(256) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `conf_no` varchar(30) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `version` bigint(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_live_video_qrcode`;
CREATE TABLE `libra_live_video_qrcode` (
  `id` varchar(32) NOT NULL,
  `nemo_id` bigint(20) NOT NULL,
  `version` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nemo_id` (`nemo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_mail_send_detail`;
CREATE TABLE `libra_mail_send_detail` (
  `id` varchar(32) NOT NULL,
  `sender` varchar(4000) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `create_time` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_mcuinfo`;
CREATE TABLE `libra_mcuinfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mcu_ip` varchar(20) NOT NULL,
  `mcu_port` int(11) NOT NULL,
  `mcu_ccap` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_mcuinfo_mcu_ip_key` (`mcu_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_bind_code`;
CREATE TABLE `libra_nemo_bind_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bind_code` varchar(32) NOT NULL,
  `device_sn` varchar(128) NOT NULL,
  `expire_time` bigint(20) DEFAULT '9223372036854775807',
  `in_use` int(11) DEFAULT '1',
  `fingerprint` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_nemo_bind_code_bind_code_key` (`bind_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1327 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_bound_number`;
CREATE TABLE `libra_nemo_bound_number` (
  `id` varchar(32) NOT NULL,
  `nemo_id` bigint(20) NOT NULL,
  `bound_number` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_charge`;
CREATE TABLE `libra_nemo_charge` (
  `id` varchar(32) NOT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `resource_type` int(11) DEFAULT NULL,
  `qualification` int(11) DEFAULT NULL,
  `nemo_sn` varchar(128) NOT NULL,
  `balance` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `libra_nemo_charge_nemo_id_fkey` (`nemo_id`),
  CONSTRAINT `libra_nemo_charge_nemo_id_fkey` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_conference_charge`;
CREATE TABLE `libra_nemo_conference_charge` (
  `id` varchar(32) NOT NULL,
  `nemo_sn` varchar(128) NOT NULL,
  `bind_time` bigint(20) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nemo_sn` (`nemo_sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_config`;
CREATE TABLE `libra_nemo_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nemo_id` bigint(20) DEFAULT NULL,
  `config_name` varchar(32) DEFAULT NULL,
  `config_value` varchar(1024) DEFAULT NULL,
  `config_expire_time` bigint(20) DEFAULT '9223372036854775807',
  PRIMARY KEY (`id`),
  KEY `libra_nemo_cap_nemo_id_fkey` (`nemo_id`),
  CONSTRAINT `libra_nemo_cap_nemo_id_fkey` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1288278 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_feature`;
CREATE TABLE `libra_nemo_feature` (
  `id` varchar(32) NOT NULL,
  `feature_id` varchar(32) DEFAULT NULL,
  `nemo_sn` varchar(128) DEFAULT NULL,
  `feature_status` int(11) DEFAULT '0',
  `target_number` varchar(20) DEFAULT NULL,
  `start_time` bigint(20) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  `trial` smallint(6) DEFAULT '0',
  `statement_agreed` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_feature` (`feature_id`),
  KEY `idxNemoFeatureSN` (`nemo_sn`),
  CONSTRAINT `fk_feature` FOREIGN KEY (`feature_id`) REFERENCES `libra_customize_feature` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_free_resource`;
CREATE TABLE `libra_nemo_free_resource` (
  `id` varchar(32) NOT NULL,
  `resource_type` smallint(6) DEFAULT '0',
  `count` bigint(20) DEFAULT '0',
  `nemo_sn` varchar(128) NOT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_model`;
CREATE TABLE `libra_nemo_model` (
  `id` varchar(32) NOT NULL,
  `nemo_sn` varchar(128) NOT NULL,
  `model` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nemo_sn` (`nemo_sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_nettool_advice`;
CREATE TABLE `libra_nemo_nettool_advice` (
  `id` varchar(32) NOT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `advice_type` int(11) DEFAULT NULL,
  `advice_description` varchar(1024) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT '9223372036854775807',
  `expire_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_nemo_nettool_advice_nemo_id_fkey` (`nemo_id`),
  CONSTRAINT `libra_nemo_nettool_advice_nemo_id_fkey` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_number`;
CREATE TABLE `libra_nemo_number` (
  `id` varchar(32) NOT NULL,
  `device_sn` varchar(128) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `magic_number` varchar(20) DEFAULT NULL,
  `createtimestamp` bigint(20) DEFAULT NULL,
  `device_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_nemo_number_device_sn_key` (`device_sn`),
  UNIQUE KEY `libra_nemo_number_magic_number_key` (`magic_number`),
  UNIQUE KEY `libra_nemo_number_number_key` (`number`),
  UNIQUE KEY `libra_nemo_number_unique` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_number_aud`;
CREATE TABLE `libra_nemo_number_aud` (
  `id` varchar(32) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `createtimestamp` bigint(20) DEFAULT NULL,
  `device_sn` varchar(128) DEFAULT NULL,
  `magic_number` varchar(20) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `device_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_nemo_number_aud_fkey` (`rev`),
  CONSTRAINT `libra_nemo_number_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_pstn_call`;
CREATE TABLE `libra_nemo_pstn_call` (
  `id` varchar(32) NOT NULL,
  `device_id` bigint(20) DEFAULT NULL,
  `nemo_uri` varchar(100) NOT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `charge` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_nemo_pstn_call_device_id_fkey` (`device_id`),
  CONSTRAINT `libra_nemo_pstn_call_device_id_fkey` FOREIGN KEY (`device_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_request`;
CREATE TABLE `libra_nemo_request` (
  `id` varchar(32) NOT NULL,
  `requester_id` bigint(20) DEFAULT NULL,
  `request_type` varchar(10) DEFAULT NULL,
  `target_nemo` bigint(20) DEFAULT NULL,
  `authority_rules` varchar(4096) DEFAULT '',
  `request_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_nemo_request_unique` (`requester_id`,`request_type`,`target_nemo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_special_contacts`;
CREATE TABLE `libra_nemo_special_contacts` (
  `id` varchar(32) NOT NULL,
  `special_contact_id` varchar(32) NOT NULL,
  `special_feature_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_nemo_trial`;
CREATE TABLE `libra_nemo_trial` (
  `id` varchar(32) NOT NULL,
  `device_sn` varchar(128) NOT NULL,
  `order_num` varchar(128) DEFAULT NULL,
  `receipt_time` bigint(20) DEFAULT NULL,
  `payment_time` bigint(20) DEFAULT NULL,
  `refer_date` bigint(20) DEFAULT NULL,
  `banding_time` bigint(20) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `inuse` varchar(10) DEFAULT NULL,
  `reciever_name` varchar(50) DEFAULT NULL,
  `reciever_phone` varchar(30) DEFAULT NULL,
  `admin_phone` varchar(30) DEFAULT NULL,
  `lock_status` varchar(10) DEFAULT NULL,
  `version` varchar(80) DEFAULT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `delay_day` smallint(6) DEFAULT '0',
  `lock_time` bigint(20) DEFAULT NULL,
  `refunding_time` bigint(20) DEFAULT NULL,
  `trial_way` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_open_nemo`;
CREATE TABLE `libra_open_nemo` (
  `id` varchar(32) NOT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `config` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_open_nemo_nemo_id_key` (`nemo_id`),
  CONSTRAINT `fk_nemoid` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_opennemo_category`;
CREATE TABLE `libra_opennemo_category` (
  `id` varchar(32) NOT NULL,
  `c_name` longtext,
  `c_order` int(11) DEFAULT NULL,
  `c_default` int(11) DEFAULT '0',
  `name_key` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_opennemo_category_nemo`;
CREATE TABLE `libra_opennemo_category_nemo` (
  `opennemo_id` varchar(32) DEFAULT NULL,
  `category_id` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_opennemo_meta`;
CREATE TABLE `libra_opennemo_meta` (
  `id` varchar(32) NOT NULL,
  `device_id` bigint(20) DEFAULT NULL,
  `real_time_image` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_opennemo_meta_device_id_key` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_operation_activity`;
CREATE TABLE `libra_operation_activity` (
  `id` varchar(32) NOT NULL,
  `type` smallint(6) DEFAULT NULL,
  `start_time` bigint(20) DEFAULT '9223372036854775807',
  `expire_time` bigint(20) DEFAULT '9223372036854775807',
  `display_duration` bigint(20) DEFAULT NULL,
  `url` varchar(1024) DEFAULT NULL,
  `image1` varchar(1024) DEFAULT NULL,
  `image2` varchar(1024) DEFAULT NULL,
  `frequency` smallint(6) DEFAULT NULL,
  `clickable` smallint(6) DEFAULT NULL,
  `target_type` smallint(6) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `client_version` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_operation_activity_user`;
CREATE TABLE `libra_operation_activity_user` (
  `id` varchar(32) NOT NULL,
  `operation_id` varchar(32) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_operation_activity_user_operation_id_fkey` (`operation_id`),
  KEY `libra_operation_activity_user_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_operation_activity_user_operation_id_fkey` FOREIGN KEY (`operation_id`) REFERENCES `libra_operation_activity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_operation_activity_user_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_physical_nemo`;
CREATE TABLE `libra_physical_nemo` (
  `virtual_nemo_id` bigint(20) DEFAULT NULL,
  `device_sn` varchar(128) NOT NULL,
  `fingerprint` varchar(16) DEFAULT NULL,
  `bind_time` bigint(20) NOT NULL,
  `unbind_time` bigint(20) DEFAULT NULL,
  KEY `libra_physical_nemo_virtual_nemo_id` (`virtual_nemo_id`),
  CONSTRAINT `libra_physical_nemo_virtual_nemo_id_fkey` FOREIGN KEY (`virtual_nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_recommend_prize`;
CREATE TABLE `libra_recommend_prize` (
  `id` varchar(32) NOT NULL,
  `prize_name` varchar(64) DEFAULT NULL,
  `prize_code` varchar(64) DEFAULT NULL,
  `prize_detail` longtext,
  `prize_probability` decimal(10,5) DEFAULT NULL,
  `prize_quantity` int(11) DEFAULT '0',
  `prize_msg_model` varchar(500) DEFAULT NULL,
  `prize_face` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_recommend_prize_record`;
CREATE TABLE `libra_recommend_prize_record` (
  `id` varchar(32) NOT NULL,
  `prize_owner` bigint(20) DEFAULT NULL,
  `prize_id` varchar(32) DEFAULT NULL,
  `prize_time` bigint(20) DEFAULT NULL,
  `prize_detail_code` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_recommend_record`;
CREATE TABLE `libra_recommend_record` (
  `id` varchar(32) NOT NULL,
  `recommender_id` bigint(20) NOT NULL,
  `order_num` varchar(128) DEFAULT NULL,
  `scored` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_recommend_score`;
CREATE TABLE `libra_recommend_score` (
  `id` varchar(32) NOT NULL,
  `recommender` bigint(20) NOT NULL,
  `init_score` int(11) DEFAULT '0',
  `earned_score` int(11) DEFAULT '0',
  `consumed_score` int(11) DEFAULT '0',
  `available_score` int(11) DEFAULT '0',
  `available_push` int(11) DEFAULT '0',
  `available_mask` int(11) DEFAULT '0',
  `order_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_recommend_score_recommender` (`recommender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_relationship_request`;
CREATE TABLE `libra_relationship_request` (
  `requester_id` bigint(20) NOT NULL,
  `requestee_id` bigint(20) NOT NULL,
  `nemos` varchar(4096) DEFAULT '',
  `authority_rules` varchar(4096) DEFAULT '',
  `request_timestamp` bigint(20) DEFAULT NULL,
  `unique_tag` varchar(64) NOT NULL,
  PRIMARY KEY (`requester_id`,`requestee_id`),
  UNIQUE KEY `unique_tag_constraint` (`unique_tag`),
  KEY `libra_relationship_request_requestee_id_fkey` (`requestee_id`),
  CONSTRAINT `libra_relationship_request_requestee_id_fkey` FOREIGN KEY (`requestee_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_relationship_request_requester_id_fkey` FOREIGN KEY (`requester_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_special_contact`;
CREATE TABLE `libra_special_contact` (
  `id` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `number` varchar(100) NOT NULL,
  `target` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_special_feature_nemo`;
CREATE TABLE `libra_special_feature_nemo` (
  `id` varchar(32) NOT NULL,
  `feature_id` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `nemo_sn` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sn_feature` (`feature_id`),
  KEY `idxSpecialFeatureSN` (`nemo_sn`),
  CONSTRAINT `fk_special_feature` FOREIGN KEY (`feature_id`) REFERENCES `libra_special_nemo_feature` (`id`),
  CONSTRAINT `libra_special_feature_nemo_feature_id_fkey` FOREIGN KEY (`feature_id`) REFERENCES `libra_special_nemo_feature` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_special_nemo_customize_feature`;
CREATE TABLE `libra_special_nemo_customize_feature` (
  `id` varchar(32) NOT NULL,
  `customize_feature_id` varchar(32) DEFAULT NULL,
  `special_feature_id` varchar(32) DEFAULT NULL,
  `target_number` varchar(20) DEFAULT NULL,
  `feature_status` smallint(6) DEFAULT '1',
  `trial` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `customize_feature_id` (`customize_feature_id`),
  KEY `special_feature_id` (`special_feature_id`),
  CONSTRAINT `libra_special_nemo_customize_feature_ibfk_1` FOREIGN KEY (`customize_feature_id`) REFERENCES `libra_customize_feature` (`id`) ON DELETE CASCADE,
  CONSTRAINT `libra_special_nemo_customize_feature_ibfk_2` FOREIGN KEY (`special_feature_id`) REFERENCES `libra_special_nemo_feature` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_special_nemo_feature`;
CREATE TABLE `libra_special_nemo_feature` (
  `id` varchar(32) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `config` longtext,
  `status` int(11) DEFAULT '0',
  `appversion` int(11) DEFAULT '0',
  `feature_type` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_system_activity`;
CREATE TABLE `libra_system_activity` (
  `id` varchar(32) NOT NULL,
  `start_time` bigint(20) DEFAULT NULL,
  `expire_time` bigint(20) DEFAULT NULL,
  `thumbnail` varchar(1024) DEFAULT NULL,
  `activity_url` varchar(1024) DEFAULT NULL,
  `activity_text` longtext,
  `activity_status` int(11) DEFAULT '1',
  `user_profile_id` bigint(20) DEFAULT '-1',
  `push_target` int(11) DEFAULT '0',
  `identifier` varchar(48) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `push_type` int(11) DEFAULT '0',
  `ios_message` varchar(1024) DEFAULT NULL,
  `android_message` varchar(1024) DEFAULT NULL,
  `client_version` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idxStartTimeSysActivity` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_system_activity_user`;
CREATE TABLE `libra_system_activity_user` (
  `id` varchar(32) NOT NULL,
  `activity_id` varchar(32) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_system_activity_user_activity_id_fkey` (`activity_id`),
  KEY `libra_system_activity_user_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_system_activity_user_activity_id_fkey` FOREIGN KEY (`activity_id`) REFERENCES `libra_system_activity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_system_activity_user_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user`;
CREATE TABLE `libra_user` (
  `id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_activity`;
CREATE TABLE `libra_user_activity` (
  `id` varchar(32) NOT NULL,
  `sys_activity_id` varchar(32) DEFAULT NULL,
  `userid` bigint(20) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `action` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_activity_tk`;
CREATE TABLE `libra_user_activity_tk` (
  `id` varchar(32) NOT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `activity_type` int(11) NOT NULL,
  `activity_id` varchar(32) NOT NULL,
  `tmp_key` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_user_activity_tk_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_user_activity_tk_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_config`;
CREATE TABLE `libra_user_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `config_name` varchar(32) DEFAULT NULL,
  `config_value` varchar(64) DEFAULT NULL,
  `config_expire_time` bigint(20) DEFAULT '9223372036854775807',
  PRIMARY KEY (`id`),
  KEY `libra_user_cap_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_user_cap_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5034 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_config_on_nemo`;
CREATE TABLE `libra_user_config_on_nemo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `config_name` varchar(32) DEFAULT NULL,
  `config_value` varchar(32) DEFAULT NULL,
  `config_expire_time` bigint(20) DEFAULT '9223372036854775807',
  PRIMARY KEY (`id`),
  KEY `libra_user_config_on_nemo_uid_nid_index` (`user_profile_id`,`nemo_id`),
  KEY `libra_user_config_on_nemo_nemo_id_fkey` (`nemo_id`),
  CONSTRAINT `libra_user_config_on_nemo_nemo_id_fkey` FOREIGN KEY (`nemo_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_user_config_on_nemo_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=75893 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_device`;
CREATE TABLE `libra_user_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_type` smallint(6) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `device_display_name` varchar(128) DEFAULT NULL,
  `device_sn` varchar(128) DEFAULT NULL,
  `device_sk` varchar(64) DEFAULT NULL,
  `device_expire_time` bigint(20) DEFAULT NULL,
  `in_use` int(11) DEFAULT '1',
  `device_presense` bigint(20) DEFAULT '2',
  `fingerprint` varchar(16) DEFAULT NULL,
  `bind_timestamp` bigint(20) DEFAULT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  `hardware_sn_unique` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_user_device_device_sk_key` (`device_sk`),
  UNIQUE KEY `libra_user_device_hardware_sn_unique_key` (`hardware_sn_unique`),
  KEY `libra_user_device_user_profile_id_fkey` (`user_profile_id`),
  KEY `idxDeviceSN` (`device_sn`),
  CONSTRAINT `libra_user_device_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10306 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_device_aud`;
CREATE TABLE `libra_user_device_aud` (
  `id` bigint(20) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `device_type` smallint(6) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `device_display_name` varchar(128) DEFAULT NULL,
  `device_sn` varchar(128) DEFAULT NULL,
  `fingerprint` varchar(16) DEFAULT NULL,
  `device_sk` varchar(64) DEFAULT NULL,
  `device_expire_time` bigint(20) DEFAULT NULL,
  `device_presense` bigint(20) DEFAULT NULL,
  `in_use` int(11) DEFAULT NULL,
  `bind_timestamp` bigint(20) DEFAULT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  `hardware_sn_unique` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_user_device_aud_fkey` (`rev`),
  CONSTRAINT `libra_user_device_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_device_privilege`;
CREATE TABLE `libra_user_device_privilege` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `target_device_id` bigint(20) DEFAULT NULL,
  `privileged_user_profile_id` bigint(20) DEFAULT NULL,
  `privileged_device_id` bigint(20) DEFAULT NULL,
  `privilege` smallint(6) NOT NULL,
  `monitor_spec` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_user_device_privilege_privileged_device_id_fkey` (`privileged_device_id`),
  KEY `libra_user_device_privilege_privileged_user_profile_id_fkey` (`privileged_user_profile_id`),
  KEY `libra_user_device_privilege_target_device_id_fkey` (`target_device_id`),
  CONSTRAINT `libra_user_device_privilege_privileged_device_id_fkey` FOREIGN KEY (`privileged_device_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_user_device_privilege_privileged_user_profile_id_fkey` FOREIGN KEY (`privileged_user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_user_device_privilege_target_device_id_fkey` FOREIGN KEY (`target_device_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=361449 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_identifier`;
CREATE TABLE `libra_user_identifier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_identifier_type` smallint(6) NOT NULL,
  `user_identifier` varchar(128) NOT NULL,
  `user_password` varchar(128) NOT NULL,
  `user_password_salt` varchar(128) NOT NULL DEFAULT 'abcd',
  `user_password_create_time` bigint(20) NOT NULL DEFAULT '1398873600000',
  `user_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_user_identifier_user_identifier_key` (`user_identifier`),
  KEY `libra_user_identifier_ref_user_id` (`user_id`),
  CONSTRAINT `libra_user_identifier_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `libra_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2470 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_invite`;
CREATE TABLE `libra_user_invite` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `friend_identifier` varchar(128) DEFAULT NULL,
  `nemos` varchar(4096) DEFAULT NULL,
  `request_time` bigint(20) DEFAULT '0',
  `agree_time` bigint(20) DEFAULT '0',
  `authority_rules` varchar(4096) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_libra_user_invite_friend_identifier` (`friend_identifier`),
  KEY `index_libra_user_invite_user_id` (`user_id`),
  CONSTRAINT `libra_user_invite_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_meeting_room`;
CREATE TABLE `libra_user_meeting_room` (
  `id` varchar(32) NOT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `conference_number_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idxUserMeetingUserId` (`user_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_nemo_relation`;
CREATE TABLE `libra_user_nemo_relation` (
  `id` varchar(32) NOT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  `nemo_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nemo_id` (`nemo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_profile`;
CREATE TABLE `libra_user_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_display_name` varchar(128) NOT NULL,
  `user_phone` varchar(32) DEFAULT NULL,
  `user_picture` varchar(128) DEFAULT NULL,
  `debug` int(11) DEFAULT '0',
  `user_create_time` bigint(20) NOT NULL DEFAULT '1398873600000',
  `phone_country_code` varchar(10) DEFAULT '+86',
  `identity_key` varchar(16) DEFAULT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `type` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_user_profile_identity_key_key` (`identity_key`),
  KEY `libra_user_profile_phone_index` (`user_phone`,`phone_country_code`),
  KEY `libra_user_profile_ref_user_id` (`user_id`),
  CONSTRAINT `libra_user_profile_ref_user_id` FOREIGN KEY (`user_id`) REFERENCES `libra_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2870 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_push`;
CREATE TABLE `libra_user_push` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `user_device_id` bigint(20) DEFAULT NULL,
  `device_token` varchar(128) DEFAULT NULL,
  `app_device_type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_user_push_token_unique` (`device_token`),
  KEY `libra_user_push_user_device_id_fkey` (`user_device_id`),
  KEY `libra_user_push_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_user_push_user_device_id_fkey` FOREIGN KEY (`user_device_id`) REFERENCES `libra_user_device` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_user_push_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14966 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_push_aud`;
CREATE TABLE `libra_user_push_aud` (
  `id` bigint(20) NOT NULL,
  `rev` int(11) NOT NULL,
  `revtype` smallint(6) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `user_device_id` bigint(20) DEFAULT NULL,
  `device_token` varchar(128) DEFAULT NULL,
  `app_device_type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`,`rev`),
  KEY `libra_user_push_aud_fkey` (`rev`),
  CONSTRAINT `libra_user_push_aud_fkey` FOREIGN KEY (`rev`) REFERENCES `revinfo` (`rev`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_user_relationship`;
CREATE TABLE `libra_user_relationship` (
  `friend1_id` bigint(20) NOT NULL,
  `friend2_id` bigint(20) NOT NULL,
  PRIMARY KEY (`friend1_id`,`friend2_id`),
  KEY `libra_user_relationship_friend2_id_fkey` (`friend2_id`),
  CONSTRAINT `libra_user_relationship_friend1_id_fkey` FOREIGN KEY (`friend1_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `libra_user_relationship_friend2_id_fkey` FOREIGN KEY (`friend2_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_virtual_nemo_number`;
CREATE TABLE `libra_virtual_nemo_number` (
  `id` varchar(32) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `target_number` varchar(10) DEFAULT NULL,
  `virtual` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_virtual_number_profile`;
CREATE TABLE `libra_virtual_number_profile` (
  `id` varchar(32) NOT NULL,
  `virtual_number` varchar(20) NOT NULL,
  `profile` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtual_number` (`virtual_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_vod_file`;
CREATE TABLE `libra_vod_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `participant_id` varchar(4096) NOT NULL,
  `filename` varchar(4096) NOT NULL,
  `start_timestamp` bigint(20) DEFAULT NULL,
  `end_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libra_vod_file_user_profile_id_fkey` (`user_profile_id`),
  CONSTRAINT `libra_vod_file_user_profile_id_fkey` FOREIGN KEY (`user_profile_id`) REFERENCES `libra_user_profile` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_vod_metadata`;
CREATE TABLE `libra_vod_metadata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recording_id` varchar(256) NOT NULL,
  `seq_id` int(11) NOT NULL,
  `end_tag` int(11) DEFAULT '0',
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NOT NULL,
  `duration` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `state` smallint(6) DEFAULT '1',
  `arrival_timestamp` bigint(20) DEFAULT NULL,
  `vod_file_id` bigint(20) DEFAULT NULL,
  `crypto_key` varchar(256) DEFAULT 'nocryptokey',
  `removed_on_nemo` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_libra_vod_metadata_nemo_id` (`nemo_id`),
  KEY `index_recording_id` (`recording_id`(191))
) ENGINE=InnoDB AUTO_INCREMENT=153150 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_vod_metadata_ex`;
CREATE TABLE `libra_vod_metadata_ex` (
  `id` varchar(32) NOT NULL,
  `recording_id` varchar(256) NOT NULL,
  `recording_gid` varchar(256) NOT NULL,
  `seq_id` int(11) NOT NULL,
  `end_tag` int(11) DEFAULT '0',
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NOT NULL,
  `duration` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `type` int(11) NOT NULL,
  `state` smallint(6) DEFAULT '1',
  `arrival_timestamp` bigint(20) DEFAULT NULL,
  `vod_file_id` varchar(32) DEFAULT NULL,
  `crypto_key` varchar(256) DEFAULT 'nocryptokey',
  `removed_on_nemo` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_libra_vod_metadata_nemo_id` (`nemo_id`),
  KEY `index_recording_id` (`recording_id`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `libra_vod_shared_file`;
CREATE TABLE `libra_vod_shared_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vod_file_id` bigint(20) DEFAULT NULL,
  `shared_status` smallint(6) DEFAULT '0',
  `shared_name` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `libra_vod_shared_file_shared_name_key` (`shared_name`),
  KEY `llibra_vod_shared_file_index` (`shared_name`),
  KEY `libra_vod_shared_file_vod_file_id_fkey` (`vod_file_id`),
  CONSTRAINT `libra_vod_shared_file_vod_file_id_fkey` FOREIGN KEY (`vod_file_id`) REFERENCES `craft_vod_file` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=709 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `occupy_floor_activity_metadata`;
CREATE TABLE `occupy_floor_activity_metadata` (
  `id` varchar(32) NOT NULL,
  `meta_id` varchar(32) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `call_duration` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `call_time_begin` bigint(20) DEFAULT NULL,
  `call_time_end` bigint(20) DEFAULT NULL,
  `floor_occupyed` bigint(20) DEFAULT NULL,
  `prize_info` varchar(256) DEFAULT NULL,
  `effective` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `occupy_floor_activity_user`;
CREATE TABLE `occupy_floor_activity_user` (
  `id` varchar(32) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `start_time` bigint(20) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `sdk_app_info`;
CREATE TABLE `sdk_app_info` (
  `id` varchar(32) NOT NULL,
  `create_time` bigint(20) DEFAULT '0',
  `app_id` varchar(30) DEFAULT NULL,
  `package_name` varchar(100) DEFAULT NULL,
  `certificate_sha1` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `sdk_meeting_info`;
CREATE TABLE `sdk_meeting_info` (
  `id` varchar(32) NOT NULL,
  `meeting_id` varchar(32) NOT NULL,
  `app_id` varchar(32) NOT NULL,
  `expire_time` bigint(20) DEFAULT '0',
  `start_time` bigint(20) DEFAULT '0',
  `max_participant_count` smallint(6) DEFAULT '25',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `sdk_user_info`;
CREATE TABLE `sdk_user_info` (
  `id` varchar(32) NOT NULL,
  `user_profile_id` bigint(20) NOT NULL,
  `port_count` bigint(20) DEFAULT '0',
  `app_id` varchar(32) NOT NULL,
  `status` smallint(6) DEFAULT '0',
  `plain_password` varchar(32) DEFAULT NULL,
  `bind_time` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_profile_id` (`user_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `slow`;
CREATE TABLE `slow` (
  `remote_addr` text,
  `remote_port` text,
  `remote_user` text,
  `time_local` text,
  `request` text,
  `date` text,
  `time` text,
  `method` text,
  `request_length` text,
  `status` text,
  `body_bytes_sent` text,
  `http_referer` text,
  `http_user_agent` text,
  `http_x_forwarded_for` text,
  `connection` text,
  `connection_requests` text,
  `request_time` text,
  `upstream_response_time` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `t_user_friend`;
CREATE TABLE `t_user_friend` (
  `id` bigint(20) NOT NULL,
  `user_1` bigint(20) DEFAULT NULL,
  `user_2` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_1_index` (`user_1`),
  KEY `user_2_index` (`user_2`),
  CONSTRAINT `t_user_friend_user_1_fkey` FOREIGN KEY (`user_1`) REFERENCES `t_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `t_user_friend_user_2_fkey` FOREIGN KEY (`user_2`) REFERENCES `t_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `test22`;
CREATE TABLE `test22` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_idd` varchar(32) DEFAULT NULL,
  `type` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `for_idd` (`user_idd`),
  CONSTRAINT `for_idd` FOREIGN KEY (`user_idd`) REFERENCES `test_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `test_cache`;
CREATE TABLE `test_cache` (
  `id` varchar(32) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(200) DEFAULT NULL,
  `age` smallint(6) DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `test_cache_child`;
CREATE TABLE `test_cache_child` (
  `id` varchar(32) NOT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `test_device`;
CREATE TABLE `test_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_profile_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `test_user`;
CREATE TABLE `test_user` (
  `id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `tmp_community_user`;
CREATE TABLE `tmp_community_user` (
  `user_profile_id` bigint(20) DEFAULT NULL,
  `community_of_one_nemo_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `tmp_user_profile_en`;
CREATE TABLE `tmp_user_profile_en` (
  `ho_id` bigint(20) DEFAULT NULL,
  `en_id` bigint(20) DEFAULT NULL,
  `u_id` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `tmp_xxjh`;
CREATE TABLE `tmp_xxjh` (
  `id` char(32) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `tmp_xxjh_image`;
CREATE TABLE `tmp_xxjh_image` (
  `id` char(32) NOT NULL,
  `url` varchar(256) DEFAULT NULL,
  `xxjh_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `weixin_to_nemo`;
CREATE TABLE `weixin_to_nemo` (
  `wexin_open_id` varchar(64) DEFAULT NULL,
  `nemo_id` bigint(20) DEFAULT NULL,
  `bind_timestamp` bigint(20) DEFAULT NULL,
  KEY `weixin_to_nemo_open_id_index` (`wexin_open_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS  `weixin_to_user`;
CREATE TABLE `weixin_to_user` (
  `wexin_open_id` varchar(64) DEFAULT NULL,
  `user_profile_id` bigint(20) DEFAULT NULL,
  `bind_timestamp` bigint(20) DEFAULT NULL,
  KEY `weixin_open_id_index` (`wexin_open_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;


-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: nexus_dev
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_area`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_area` (
  `access_area_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `area_capacity` int(10) unsigned NOT NULL,
  `count_start_time` datetime DEFAULT NULL,
  PRIMARY KEY (`access_area_id`),
  KEY `FK_access_area_location` (`location_id`),
  CONSTRAINT `FK_access_area_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_mode`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_mode` (
  `access_mode_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`access_mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_point`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_point` (
  `access_point_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `access_point_type_id` int(10) unsigned NOT NULL DEFAULT '1',
  `to_access_area_id` int(10) unsigned DEFAULT NULL,
  `from_access_area_id` int(10) unsigned DEFAULT NULL,
  `device_id` int(10) unsigned NOT NULL DEFAULT '0',
  `timetable_id` int(10) unsigned DEFAULT NULL,
  `access_mode_id` int(10) unsigned NOT NULL DEFAULT '2',
  `is_collecting` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `gender_id` tinyint(1) unsigned DEFAULT NULL,
  `is_gender_strict` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_exit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `override_access_mode_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`access_point_id`),
  KEY `FK_access_point_to_access_area_id` (`to_access_area_id`),
  KEY `FK_access_point_from_access_area_id` (`from_access_area_id`),
  KEY `FK_access_point_device_id` (`device_id`),
  KEY `FK_access_point_timetable_id` (`timetable_id`),
  KEY `FK_access_point_type` (`access_point_type_id`),
  KEY `FK_access_point_mode` (`access_mode_id`),
  KEY `FK_access_point_gender` (`gender_id`),
  KEY `FK_access_point_override_mode` (`override_access_mode_id`),
  CONSTRAINT `FK_access_point_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_access_point_from_access_area` FOREIGN KEY (`from_access_area_id`) REFERENCES `access_area` (`access_area_id`) ON DELETE SET NULL,
  CONSTRAINT `FK_access_point_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_access_point_mode` FOREIGN KEY (`access_mode_id`) REFERENCES `access_mode` (`access_mode_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_access_point_override_mode` FOREIGN KEY (`override_access_mode_id`) REFERENCES `access_mode` (`access_mode_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_access_point_timetable_id` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_access_point_to_access_area` FOREIGN KEY (`to_access_area_id`) REFERENCES `access_area` (`access_area_id`) ON DELETE SET NULL,
  CONSTRAINT `FK_access_point_type` FOREIGN KEY (`access_point_type_id`) REFERENCES `access_point_type` (`access_point_type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_point_type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_point_type` (
  `access_point_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`access_point_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_right`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_right` (
  `access_right_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL DEFAULT '0',
  `access_right_template_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `sale_event_id` int(10) unsigned DEFAULT NULL,
  `loading_timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `charging_timestamp` datetime DEFAULT NULL,
  `validation_timestamp` datetime DEFAULT NULL,
  `validation_expiration` datetime DEFAULT NULL,
  `charging_expiration` datetime DEFAULT NULL,
  `access_right_expiration` datetime DEFAULT NULL,
  `current_location_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `shared_quantity_id` int(10) unsigned DEFAULT NULL,
  `pin` varchar(10) DEFAULT NULL,
  `validations_today` int(11) NOT NULL DEFAULT '0',
  `validations_this_week` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`access_right_id`),
  KEY `FK_access_right_access_right_template` (`access_right_template_id`),
  KEY `FK_access_right_account` (`account_id`),
  KEY `FK_access_right_current_location` (`current_location_id`),
  KEY `FK_access_right_sale` (`sale_event_id`),
  KEY `FK_access_right_shared_quantity` (`shared_quantity_id`),
  KEY `FK_access_right_pin` (`pin`),
  CONSTRAINT `FK_access_right_access_right_template` FOREIGN KEY (`access_right_template_id`) REFERENCES `access_right_template` (`access_right_template_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_access_right_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_access_right_current_location` FOREIGN KEY (`current_location_id`) REFERENCES `service_at_area` (`service_at_area_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_access_right_sale` FOREIGN KEY (`sale_event_id`) REFERENCES `event_sale` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_access_right_shared_quantity` FOREIGN KEY (`shared_quantity_id`) REFERENCES `shared_quantity` (`shared_quantity_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_right_template`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_right_template` (
  `access_right_template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `service_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `validation_duration` int(10) unsigned NOT NULL DEFAULT '7200',
  `charging_duration` int(10) unsigned NOT NULL DEFAULT '7200',
  `access_right_duration` int(10) unsigned NOT NULL DEFAULT '31536000',
  `valid_from_date` date DEFAULT NULL,
  `valid_until_date` date DEFAULT NULL,
  `timetable_id` int(10) unsigned DEFAULT NULL,
  `is_anonymous` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_pin_access_right` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `day_limit` int(11) DEFAULT NULL,
  `week_limit` int(11) unsigned DEFAULT NULL,
  `default_for_location_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`access_right_template_id`),
  KEY `FK_access_right_template_service_group` (`service_group_id`),
  KEY `FK_access_right_template_timetable` (`timetable_id`),
  KEY `FK_access_right_template_location_id` (`default_for_location_id`),
  CONSTRAINT `FK_access_right_template_location_id` FOREIGN KEY (`default_for_location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_access_right_template_service_group` FOREIGN KEY (`service_group_id`) REFERENCES `service_group` (`service_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_access_right_template_timetable` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_group_id` int(10) unsigned NOT NULL DEFAULT '1',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `pin` varchar(255) DEFAULT NULL,
  `current_area_id` int(10) unsigned DEFAULT NULL,
  `current_service_at_area_id` int(10) unsigned DEFAULT NULL,
  `gender_id` tinyint(1) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `access_timestamp` datetime DEFAULT NULL,
  `ta_status_id` int(10) unsigned DEFAULT NULL,
  `is_gender_auto` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `parent_account_id` int(10) unsigned DEFAULT NULL,
  `is_child_account_reserved` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reservations_blocked_until` date DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `FK_account_customer_group` (`customer_group_id`),
  KEY `FK_account_area` (`current_area_id`),
  KEY `FK_account_service_at_area` (`current_service_at_area_id`),
  KEY `FK_account_gender` (`gender_id`),
  KEY `FK_account_user` (`user_id`),
  KEY `FK_account_ta_status` (`ta_status_id`),
  KEY `FK_account_parent_account_id` (`parent_account_id`),
  KEY `account_access_timestamp` (`access_timestamp`),
  CONSTRAINT `FK_account_area` FOREIGN KEY (`current_area_id`) REFERENCES `access_area` (`access_area_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_account_customer_group` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`),
  CONSTRAINT `FK_account_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_account_service_at_area` FOREIGN KEY (`current_service_at_area_id`) REFERENCES `service_at_area` (`service_at_area_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_account_ta_status` FOREIGN KEY (`ta_status_id`) REFERENCES `ta_status` (`ta_status_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_account_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_balance`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_balance` (
  `account_balance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_type_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `balance_identifier` varchar(50) DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `balance` int(10) NOT NULL DEFAULT '0',
  `balance_lower_limit` int(10) NOT NULL DEFAULT '0',
  `start_time` datetime DEFAULT NULL,
  `expiration_time` datetime DEFAULT NULL,
  PRIMARY KEY (`account_balance_id`),
  KEY `FK_account_balance_account` (`account_id`),
  KEY `FK_account_balance_organization` (`organization_id`),
  KEY `FK_account_balance_payment_type` (`payment_type_id`),
  KEY `index_balance_identifier` (`balance_identifier`),
  KEY `index_expiration_time` (`expiration_time`),
  KEY `index_start_time` (`start_time`),
  CONSTRAINT `FK_account_balance_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_account_balance_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_account_balance_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_property`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_property` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(45) NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`,`property_id`),
  KEY `FK_account_property` (`property_id`),
  CONSTRAINT `FK_account_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_account_property_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_tag`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_tag` (
  `account_tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `employee_id` int(10) unsigned DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`account_tag_id`),
  KEY `FK_account_tag` (`tag_id`),
  KEY `FK_account_tag_account` (`account_id`),
  KEY `FK_account_tag_employee` (`employee_id`),
  CONSTRAINT `FK_account_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_account_tag_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_account_tag_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_organization_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(45) DEFAULT NULL,
  `service_organization_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info` text,
  `discount_percentage` int(10) unsigned DEFAULT NULL,
  `compensation_percentage` int(10) unsigned DEFAULT NULL,
  `is_editable` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_anonymous_allowed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_reference_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_resource_reservation_allowed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `reference_name` varchar(45) DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT '0',
  `credit_limit` int(10) unsigned DEFAULT NULL,
  `balance_timestamp` datetime DEFAULT NULL,
  `shortcut` varchar(10) DEFAULT NULL,
  `invoicing_period_id` int(10) unsigned DEFAULT NULL,
  `invoicing_address` text,
  `reference` varchar(45) DEFAULT NULL,
  `override_account_no` varchar(10) DEFAULT NULL,
  `invoicing_charge_fare_product_id` int(10) unsigned DEFAULT NULL,
  `contract_type_code` tinyint(1) unsigned DEFAULT NULL,
  `external_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`agreement_id`),
  KEY `FK_agreement_customer` (`customer_organization_id`),
  KEY `FK_agreement_service_organization` (`service_organization_id`),
  KEY `FK_agreement_location` (`location_id`),
  KEY `FK_agreement_invoicing_period` (`invoicing_period_id`),
  KEY `FK_agreement_invoicing_charge_fare_product` (`invoicing_charge_fare_product_id`),
  CONSTRAINT `FK_agreement_customer` FOREIGN KEY (`customer_organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_agreement_invoicing_charge_fare_product` FOREIGN KEY (`invoicing_charge_fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_agreement_invoicing_period` FOREIGN KEY (`invoicing_period_id`) REFERENCES `invoicing_period` (`invoicing_period_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_agreement_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_agreement_service_organization` FOREIGN KEY (`service_organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement_account`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agreement_account` (
  `agreement_id` int(10) unsigned NOT NULL DEFAULT '0',
  `account_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_used` datetime DEFAULT NULL,
  `agreement_reference` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`,`agreement_id`),
  KEY `FK_agreement_account_agreement` (`agreement_id`),
  CONSTRAINT `FK_agreement_account_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_agreement_account_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement_product`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agreement_product` (
  `agreement_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agreement_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fare_product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` int(10) unsigned DEFAULT NULL,
  `compensation` int(10) unsigned DEFAULT NULL,
  `compensation_percentage` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`agreement_product_id`),
  KEY `FK_agreement_product_agreement` (`agreement_id`),
  KEY `FK_agreement_product_fare_product` (`fare_product_id`),
  CONSTRAINT `FK_agreement_product_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_agreement_product_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement_tag`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agreement_tag` (
  `agreement_tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agreement_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`agreement_tag_id`),
  UNIQUE KEY `agreement_name` (`agreement_id`,`name`),
  KEY `FK_agreement` (`agreement_id`),
  KEY `name` (`name`),
  CONSTRAINT `FK_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm` (
  `alarm_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL,
  `is_rearmed_automatically` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rearm_duration` int(10) unsigned NOT NULL DEFAULT '20',
  `is_pin_required_for_disarm` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_armed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `status_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`alarm_id`),
  KEY `FK_alarm_device` (`device_id`),
  CONSTRAINT `FK_alarm_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_provider`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_provider` (
  `auth_provider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`auth_provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_row`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bundle_row` (
  `bundle_row_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bundle_fare_product_id` int(10) unsigned NOT NULL,
  `ui_order` int(3) unsigned NOT NULL DEFAULT '0',
  `row_fare_product_id` int(10) unsigned NOT NULL,
  `price` int(10) unsigned DEFAULT NULL,
  `account_number` varchar(10) DEFAULT NULL,
  `quantity` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`bundle_row_id`),
  KEY `FK_bundle_row_bfp` (`bundle_fare_product_id`),
  KEY `FK_bundle_row_rfp` (`row_fare_product_id`),
  CONSTRAINT `FK_bundle_row_bfp` FOREIGN KEY (`bundle_fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bundle_row_rfp` FOREIGN KEY (`row_fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `button`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `button` (
  `button_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `button_set_id` int(10) unsigned NOT NULL,
  `button_number` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `ta_status_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`button_id`),
  KEY `FK_button_set` (`button_set_id`),
  KEY `FK_button_ta_status` (`ta_status_id`),
  CONSTRAINT `FK_button_set` FOREIGN KEY (`button_set_id`) REFERENCES `button_set` (`button_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_button_ta_status` FOREIGN KEY (`ta_status_id`) REFERENCES `ta_status` (`ta_status_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `button_layout`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `button_layout` (
  `button_layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `rows` int(10) unsigned DEFAULT NULL,
  `columns` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`button_layout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `button_set`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `button_set` (
  `button_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `short_name` varchar(45) DEFAULT NULL,
  `button_layout_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`button_set_id`),
  KEY `FK_button_set_layout` (`button_layout_id`),
  CONSTRAINT `FK_button_set_layout` FOREIGN KEY (`button_layout_id`) REFERENCES `button_layout` (`button_layout_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `button_set_organization`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `button_set_organization` (
  `button_set_organization_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `button_set_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `ui_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`button_set_organization_id`),
  KEY `FK_button_set_organization` (`organization_id`),
  KEY `FK_button_set_organization_set` (`button_set_id`),
  CONSTRAINT `FK_button_set_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_button_set_organization_set` FOREIGN KEY (`button_set_id`) REFERENCES `button_set` (`button_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_day`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_day` (
  `calendar_day_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `day_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`calendar_day_id`),
  KEY `FK_calendar_day_type` (`day_type_id`),
  CONSTRAINT `FK_calendar_day_type` FOREIGN KEY (`day_type_id`) REFERENCES `day_type` (`day_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camera`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camera` (
  `camera_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `passwd` varchar(45) DEFAULT NULL,
  `auth_scheme` varchar(45) DEFAULT NULL,
  `image_capture_delay` int(11) unsigned DEFAULT NULL,
  `prebuffer_duration` int(11) unsigned DEFAULT NULL,
  `postbuffer_duration` int(11) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`camera_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camera_event`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camera_event` (
  `camera_event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` int(10) unsigned NOT NULL,
  `time_start` datetime NOT NULL,
  `time_end` datetime DEFAULT NULL,
  `imagecount` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`camera_event_id`),
  KEY `time_start` (`time_start`),
  KEY `camera_id` (`camera_id`,`time_start`),
  CONSTRAINT `FK_camera_event_camera_id` FOREIGN KEY (`camera_id`) REFERENCES `camera` (`camera_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camera_link`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camera_link` (
  `camera_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` int(10) unsigned NOT NULL,
  `device_id` int(10) unsigned NOT NULL,
  `access_point_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`camera_link_id`),
  UNIQUE KEY `camera_id` (`camera_id`,`device_id`,`access_point_id`),
  KEY `FK_device_id` (`device_id`),
  KEY `FK_access_point_id` (`access_point_id`),
  CONSTRAINT `FK_access_point_id` FOREIGN KEY (`access_point_id`) REFERENCES `access_point` (`access_point_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_camera_id` FOREIGN KEY (`camera_id`) REFERENCES `camera` (`camera_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_device_id` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign` (
  `campaign_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `discount_percentage` int(10) unsigned DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `sale_group_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`campaign_id`),
  KEY `FK_campaign_sale_group` (`sale_group_id`),
  KEY `FK_campaign_location_id` (`location_id`),
  CONSTRAINT `FK_campaign_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_campaign_sale_group` FOREIGN KEY (`sale_group_id`) REFERENCES `sale_group` (`sale_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaign_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign_product` (
  `campaign_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fare_product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `discount_percentage` int(10) unsigned DEFAULT NULL,
  `discount_price` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`campaign_product_id`),
  UNIQUE KEY `Index_campaign_fare` (`campaign_id`,`fare_product_id`),
  KEY `FK_campaign_product_fare` (`fare_product_id`),
  CONSTRAINT `FK_campaign_product_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`campaign_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_campaign_product_fare` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_payment_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_payment_type` (
  `card_payment_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `code` varchar(5) NOT NULL DEFAULT '',
  `override_account_no` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`card_payment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `FK_contact_agreement` (`agreement_id`),
  KEY `FK_contact_organization` (`organization_id`),
  KEY `FK_contact_user` (`user_id`),
  CONSTRAINT `FK_contact_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_contact_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_contact_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversion`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversion` (
  `conversion_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conversion_table_id` int(10) unsigned NOT NULL DEFAULT '0',
  `source_id` varchar(45) NOT NULL DEFAULT '',
  `target_id` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`conversion_id`),
  KEY `FK_conversion_table_id` (`conversion_table_id`),
  KEY `index_table_source` (`conversion_table_id`,`source_id`),
  KEY `index_table_target` (`conversion_table_id`,`target_id`),
  CONSTRAINT `FK_conversion_table_id` FOREIGN KEY (`conversion_table_id`) REFERENCES `conversion_table` (`conversion_table_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversion_field`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversion_field` (
  `conversion_field_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `conversion_table_id` int(10) unsigned NOT NULL DEFAULT '0',
  `source_field` varchar(45) NOT NULL DEFAULT '',
  `target_field` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`conversion_field_id`),
  KEY `FK_conversion_field_table` (`conversion_table_id`),
  CONSTRAINT `FK_conversion_field_table` FOREIGN KEY (`conversion_table_id`) REFERENCES `conversion_table` (`conversion_table_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversion_table`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversion_table` (
  `conversion_table_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `source_system` varchar(100) NOT NULL,
  `source_object` varchar(100) NOT NULL,
  `target_object` varchar(100) NOT NULL,
  PRIMARY KEY (`conversion_table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost_center`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cost_center` (
  `cost_center_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `service_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cost_center_id`),
  UNIQUE KEY `Index_location_service_group` (`location_id`,`service_group_id`),
  KEY `FK_cost_center_service_group` (`service_group_id`),
  CONSTRAINT `FK_cost_center_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cost_center_service_group` FOREIGN KEY (`service_group_id`) REFERENCES `service_group` (`service_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_group` (
  `customer_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `ui_order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_for_event`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_for_event` (
  `event_id` int(10) unsigned NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  PRIMARY KEY (`event_id`,`key`),
  CONSTRAINT `FK_data_for_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `day_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `day_type` (
  `day_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`day_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delivery_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_type` (
  `delivery_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `fare_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`delivery_type_id`),
  KEY `delivery_type_fare_product` (`fare_product_id`),
  CONSTRAINT `delivery_type_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `device_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `device_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `organization_id` int(10) unsigned NOT NULL DEFAULT '0',
  `location_id` int(10) unsigned DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default_user_id` int(10) unsigned NOT NULL DEFAULT '3',
  `current_version` varchar(65) DEFAULT NULL,
  `desired_version` varchar(45) DEFAULT NULL,
  `shift_event_id` int(10) unsigned DEFAULT NULL,
  `timetable_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `FK_device_device_type` (`device_type_id`),
  KEY `FK_device_organization` (`organization_id`),
  KEY `FK_device_location` (`location_id`),
  KEY `FK_device_user` (`default_user_id`),
  KEY `FK_device_shift` (`shift_event_id`),
  KEY `FK_device_timetable` (`timetable_id`),
  CONSTRAINT `FK_device_device_type` FOREIGN KEY (`device_type_id`) REFERENCES `device_type` (`device_type_id`),
  CONSTRAINT `FK_device_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `FK_device_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_device_shift` FOREIGN KEY (`shift_event_id`) REFERENCES `event` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_device_timetable` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_device_user` FOREIGN KEY (`default_user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_access_point`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_access_point` (
  `device_access_point_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL,
  `is_locked` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `locked_status_timestamp` datetime DEFAULT NULL,
  `is_closed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `closed_status_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`device_access_point_id`),
  UNIQUE KEY `index_device` (`device_id`),
  CONSTRAINT `FK_device_access_point_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_config`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_config` (
  `device_config_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_hardware_id` int(10) unsigned DEFAULT NULL,
  `system_id` int(10) unsigned DEFAULT NULL,
  `original_device_id` int(10) unsigned DEFAULT NULL,
  `device_type_id` int(10) unsigned DEFAULT NULL,
  `software_version` varchar(45) DEFAULT NULL,
  `device_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `config_version` varchar(45) DEFAULT NULL,
  `package_url` text,
  `executable` varchar(100) DEFAULT NULL,
  `config` text,
  `certificate_url` text,
  PRIMARY KEY (`device_config_id`),
  KEY `FK_device_config_device_id` (`device_id`),
  KEY `FK_device_config_system` (`system_id`),
  KEY `FK_device_config_hardware` (`device_hardware_id`),
  KEY `FK_device_config_type` (`device_type_id`),
  CONSTRAINT `FK_device_config_device_id` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_device_config_hardware` FOREIGN KEY (`device_hardware_id`) REFERENCES `device_hardware` (`device_hardware_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_device_config_system` FOREIGN KEY (`system_id`) REFERENCES `system` (`system_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_device_config_type` FOREIGN KEY (`device_type_id`) REFERENCES `device_type` (`device_type_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_hardware`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_hardware` (
  `device_hardware_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mac` varchar(100) DEFAULT NULL,
  `cpu` varchar(100) DEFAULT NULL,
  `flash` varchar(100) DEFAULT NULL,
  `checksums` text,
  `info` text,
  `last_seen` datetime DEFAULT NULL,
  `auth_token` varchar(100) DEFAULT NULL,
  `is_configured` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rtunnel_port` varchar(100) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`device_hardware_id`),
  UNIQUE KEY `auth_token` (`auth_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_payment_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_payment_type` (
  `device_payment_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned NOT NULL,
  `override_account_no` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`device_payment_type_id`),
  UNIQUE KEY `FK_device_payment_type_device` (`device_id`,`payment_type_id`),
  KEY `FK_device_payment_type` (`payment_type_id`),
  CONSTRAINT `FK_device_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_device_payment_type_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_sale_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_sale_group` (
  `sale_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_group_id`,`device_id`),
  KEY `FK_device_sale_group_device` (`device_id`),
  CONSTRAINT `FK_device_sale_group_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_device_sale_group_sale_group` FOREIGN KEY (`sale_group_id`) REFERENCES `sale_group` (`sale_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_status`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_status` (
  `device_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL,
  `class` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `number` varchar(10) DEFAULT NULL,
  `status_name` varchar(100) NOT NULL,
  `status_value` varchar(100) DEFAULT NULL,
  `last_seen_timestamp` datetime NOT NULL,
  `last_changed_timestamp` datetime NOT NULL,
  PRIMARY KEY (`device_status_id`),
  UNIQUE KEY `unique_index` (`device_id`,`class`,`model`,`number`,`status_name`),
  CONSTRAINT `device_status_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_type` (
  `device_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `software_version` varchar(45) DEFAULT NULL,
  `package_url` text NOT NULL,
  `executable` varchar(100) NOT NULL,
  `config` text NOT NULL,
  PRIMARY KEY (`device_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edit_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edit_type` (
  `edit_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`edit_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `employee_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `salary_rate_id` int(10) unsigned DEFAULT NULL,
  `balance_timestamp` datetime DEFAULT NULL,
  `ta_rule_id` int(10) unsigned DEFAULT NULL,
  `employee_group_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `commissioner_organization_id` int(10) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `work_type_tax_code` tinyint(3) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`employee_id`),
  KEY `FK_employee_salary_rate` (`salary_rate_id`),
  KEY `FK_employee_user` (`user_id`),
  KEY `FK_employee_ta_rule` (`ta_rule_id`),
  KEY `FK_employee_group` (`employee_group_id`),
  KEY `FK_employee_organization` (`organization_id`),
  KEY `FK_employee_location` (`location_id`),
  KEY `FK_employee_organization_2` (`commissioner_organization_id`),
  CONSTRAINT `FK_employee_group` FOREIGN KEY (`employee_group_id`) REFERENCES `employee_group` (`employee_group_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_organization_2` FOREIGN KEY (`commissioner_organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_salary_rate` FOREIGN KEY (`salary_rate_id`) REFERENCES `salary_rate` (`salary_rate_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_ta_rule` FOREIGN KEY (`ta_rule_id`) REFERENCES `ta_rule` (`ta_rule_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_group` (
  `employee_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`employee_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(10) unsigned NOT NULL DEFAULT '0',
  `event_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `raw_data_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `shift_event_id` int(10) unsigned DEFAULT NULL,
  `journey_event_id` int(10) unsigned DEFAULT NULL,
  `comment` text,
  `receipt_event_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_device` (`device_id`),
  KEY `FK_event_user` (`user_id`),
  KEY `Index_timestamp` (`timestamp`),
  KEY `FK_event_raw_data` (`raw_data_id`),
  KEY `FK_event_receipt` (`receipt_event_id`),
  KEY `FK_event_journey_event` (`journey_event_id`),
  KEY `FK_event_shift_event` (`shift_event_id`),
  KEY `FK_event_event_type` (`event_type_id`),
  KEY `index_event_type_timestamp` (`event_type_id`,`timestamp`),
  CONSTRAINT `FK_event_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`),
  CONSTRAINT `FK_event_event_type` FOREIGN KEY (`event_type_id`) REFERENCES `event_type` (`event_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_journey_event` FOREIGN KEY (`journey_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_event_raw_data` FOREIGN KEY (`raw_data_id`) REFERENCES `raw_data` (`raw_data_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_event_receipt` FOREIGN KEY (`receipt_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_shift_event` FOREIGN KEY (`shift_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_event_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_access`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_access` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_point_id` int(10) unsigned DEFAULT NULL,
  `access_area_id` int(10) unsigned DEFAULT NULL,
  `service_at_area_id` int(10) unsigned DEFAULT NULL,
  `ta_status_id` int(10) unsigned DEFAULT NULL,
  `ta_shift_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_access_access_point` (`access_point_id`),
  KEY `FK_event_access_access_area` (`access_area_id`),
  KEY `FK_event_access_service_at_area` (`service_at_area_id`),
  KEY `FK_event_access_ta_status` (`ta_status_id`),
  KEY `FK_event_access_ta_shift` (`ta_shift_id`),
  CONSTRAINT `FK_event_access_access_area` FOREIGN KEY (`access_area_id`) REFERENCES `access_area` (`access_area_id`),
  CONSTRAINT `FK_event_access_access_point` FOREIGN KEY (`access_point_id`) REFERENCES `access_point` (`access_point_id`),
  CONSTRAINT `FK_event_access_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_access_service_at_area` FOREIGN KEY (`service_at_area_id`) REFERENCES `service_at_area` (`service_at_area_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_access_ta_shift` FOREIGN KEY (`ta_shift_id`) REFERENCES `ta_shift` (`ta_shift_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_event_access_ta_status` FOREIGN KEY (`ta_status_id`) REFERENCES `ta_status` (`ta_status_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_agreement`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_agreement` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `agreement_product_id` int(10) unsigned DEFAULT NULL,
  `agreement_account_id` int(10) unsigned DEFAULT NULL,
  `sale_event_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_agreement_agreement` (`agreement_id`),
  KEY `FK_event_agreement_product` (`agreement_product_id`),
  KEY `FK_event_agreement_account` (`agreement_account_id`),
  KEY `FK_event_agreement_sale` (`sale_event_id`),
  CONSTRAINT `FK_event_agreement_account` FOREIGN KEY (`agreement_account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_agreement_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_agreement_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_agreement_product` FOREIGN KEY (`agreement_product_id`) REFERENCES `agreement_product` (`agreement_product_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_agreement_sale` FOREIGN KEY (`sale_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_alarm`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_alarm` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acknowledged_user_id` int(10) unsigned DEFAULT NULL,
  `resolved_user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_resolved_user_id` (`resolved_user_id`),
  KEY `FK_event_acknowledged_user_id` (`acknowledged_user_id`),
  CONSTRAINT `FK_event_acknowledged_user_id` FOREIGN KEY (`acknowledged_user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_event_id` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_resolved_user_id` FOREIGN KEY (`resolved_user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_balance`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_balance` (
  `event_id` int(10) unsigned NOT NULL,
  `account_balance_id` int(10) unsigned DEFAULT NULL,
  `balance_identifier` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_balance_account_balance` (`account_balance_id`),
  KEY `event_balance_event` (`event_id`),
  CONSTRAINT `event_balance_account_balance` FOREIGN KEY (`account_balance_id`) REFERENCES `account_balance` (`account_balance_id`) ON UPDATE CASCADE,
  CONSTRAINT `event_balance_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_deleted`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_deleted` (
  `event_id` int(10) unsigned NOT NULL,
  `is_deleted` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `event_quantity_event` (`event_id`),
  CONSTRAINT `FK_event_deleted_event_id` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_edit`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_edit` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_name` varchar(45) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `edit` text NOT NULL,
  `edit_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `index_object` (`object_name`,`object_id`),
  KEY `FK_event_edit_type` (`edit_type_id`),
  CONSTRAINT `FK_event_edit_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_edit_type` FOREIGN KEY (`edit_type_id`) REFERENCES `edit_type` (`edit_type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_inspection`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_inspection` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inspection_message` text CHARACTER SET latin1,
  `inspection_status` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `inspection_result` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_access_allowed` tinyint(1) unsigned DEFAULT '0',
  `is_collect_token` tinyint(1) unsigned DEFAULT '0',
  `signal_tower_color` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `inspection_data` text CHARACTER SET latin1,
  PRIMARY KEY (`event_id`),
  CONSTRAINT `FK_event_inspection_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_inventory`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_inventory` (
  `event_id` int(10) unsigned NOT NULL,
  `inventory_event_type_id` int(10) unsigned NOT NULL,
  `inventory_item_id` int(10) unsigned DEFAULT NULL,
  `inventory_batch_id` int(10) unsigned DEFAULT NULL,
  `inventory_quantity` int(10) NOT NULL,
  `inventory_unit_cost` float DEFAULT NULL,
  `inventory_sale_event_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_inventory_batch` (`inventory_batch_id`),
  KEY `event_inventory_event_type` (`inventory_event_type_id`),
  KEY `event_inventory_item` (`inventory_item_id`),
  KEY `event_inventory_sale_event` (`inventory_sale_event_id`),
  CONSTRAINT `event_inventory_batch` FOREIGN KEY (`inventory_batch_id`) REFERENCES `inventory_batch` (`inventory_batch_id`) ON UPDATE CASCADE,
  CONSTRAINT `event_inventory_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_inventory_event_type` FOREIGN KEY (`inventory_event_type_id`) REFERENCES `inventory_event_type` (`inventory_event_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `event_inventory_item` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_item` (`inventory_item_id`) ON UPDATE CASCADE,
  CONSTRAINT `event_inventory_sale_event` FOREIGN KEY (`inventory_sale_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_locker`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_locker` (
  `event_id` int(10) unsigned NOT NULL,
  `locker_id` int(10) unsigned NOT NULL,
  `is_locked` tinyint(1) unsigned DEFAULT NULL,
  `is_battery_low` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_field_locker` (`locker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_log`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_log` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_level_id` int(10) unsigned NOT NULL DEFAULT '1',
  `message` text NOT NULL,
  `page_name` varchar(45) NOT NULL DEFAULT '',
  `execution_time` float DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_log_log_level` (`log_level_id`),
  KEY `Index_page_name` (`page_name`),
  CONSTRAINT `FK_event_log_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_log_log_level` FOREIGN KEY (`log_level_id`) REFERENCES `log_level` (`log_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_message`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_message` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL,
  `message_status_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_message_id` (`message_id`),
  CONSTRAINT `FK_message_id` FOREIGN KEY (`message_id`) REFERENCES `message` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_order`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_order` (
  `event_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `order_info` text,
  PRIMARY KEY (`event_id`),
  CONSTRAINT `event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_payment`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_payment` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `payment_amount` int(11) NOT NULL DEFAULT '0',
  `is_processed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `original_payment_event_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_payment_payment_type` (`payment_type_id`),
  CONSTRAINT `FK_event_payment_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_payment_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_payment_card`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_payment_card` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `card_payment_type_id` int(10) unsigned DEFAULT NULL,
  `archive_no` varchar(100) DEFAULT NULL,
  `payment_log` text,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_payment_card_type` (`card_payment_type_id`),
  CONSTRAINT `FK_event_payment_card_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_payment_card_type` FOREIGN KEY (`card_payment_type_id`) REFERENCES `card_payment_type` (`card_payment_type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_payment_invoice`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_payment_invoice` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_row_id` int(10) unsigned DEFAULT NULL,
  `invoicing_period_id` int(10) unsigned DEFAULT NULL,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_invoice_row` (`invoice_row_id`),
  KEY `FK_event_invoicing_period_id` (`invoicing_period_id`),
  KEY `FK_event_payment_invoice_id` (`invoice_id`),
  CONSTRAINT `FK_event_invoice_row` FOREIGN KEY (`invoice_row_id`) REFERENCES `invoice_row` (`invoice_row_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_event_invoicing_period_id` FOREIGN KEY (`invoicing_period_id`) REFERENCES `invoicing_period` (`invoicing_period_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_payment_invoice_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_product` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_right_id` int(10) unsigned DEFAULT NULL,
  `fare_product_id` int(10) unsigned DEFAULT NULL,
  `balance` int(10) unsigned DEFAULT NULL,
  `reservation_event_id` int(10) unsigned DEFAULT NULL,
  `reservation_event_group_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_product_access_right` (`access_right_id`),
  KEY `FK_event_product_fare_product` (`fare_product_id`),
  KEY `FK_event_product_reservation_event` (`reservation_event_id`),
  KEY `FK_event_product_reservation_event_group` (`reservation_event_group_id`),
  CONSTRAINT `FK_event_product_access_right` FOREIGN KEY (`access_right_id`) REFERENCES `access_right` (`access_right_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_product_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_product_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_product_reservation_event` FOREIGN KEY (`reservation_event_id`) REFERENCES `reservation_event` (`reservation_event_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_product_reservation_event_group` FOREIGN KEY (`reservation_event_group_id`) REFERENCES `reservation_event_group` (`reservation_event_group_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_quantity`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_quantity` (
  `event_id` int(10) unsigned NOT NULL,
  `event_quantity` int(10) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_quantity_event` (`event_id`),
  CONSTRAINT `event_quantity_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_receipt`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_receipt` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_closed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `total_amount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  CONSTRAINT `FK_event_receipt_event2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_return`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_return` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `original_sale_event_id` int(10) unsigned DEFAULT NULL,
  `return_sale_event_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `FK_event_return_original` (`original_sale_event_id`),
  KEY `FK_event_return_sale` (`return_sale_event_id`),
  CONSTRAINT `FK_event_return_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_return_original` FOREIGN KEY (`original_sale_event_id`) REFERENCES `event` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_event_return_sale` FOREIGN KEY (`return_sale_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_sale`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_sale` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` int(11) NOT NULL DEFAULT '0',
  `vat_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `vat_amount` int(11) NOT NULL DEFAULT '0',
  `is_rounding` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `second_vat_group_id` int(10) unsigned DEFAULT NULL,
  `second_vat_amount` int(10) unsigned DEFAULT NULL,
  `amount_for_second_vat` int(10) unsigned DEFAULT NULL,
  `bundle_event_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_sale_vat_group` (`vat_group_id`),
  KEY `FK_event_sale_vat2` (`second_vat_group_id`),
  KEY `FK_event_sale_bundle_event` (`bundle_event_id`),
  CONSTRAINT `FK_event_sale_bundle_event` FOREIGN KEY (`bundle_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_sale_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_sale_vat2` FOREIGN KEY (`second_vat_group_id`) REFERENCES `vat_group` (`vat_group_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_sale_vat_group` FOREIGN KEY (`vat_group_id`) REFERENCES `vat_group` (`vat_group_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_shift`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_shift` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `total_cash_amount` int(10) DEFAULT NULL,
  `total_coupon_quantity` int(10) unsigned DEFAULT NULL,
  `total_coupon_amount` int(10) unsigned DEFAULT NULL,
  `is_shift_closed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `closing_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  CONSTRAINT `FK_event_shift_event2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_subscription`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_subscription` (
  `event_id` int(10) unsigned NOT NULL,
  `subscription_id` int(10) unsigned DEFAULT NULL,
  `subscription_payment_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event_subscription_subscription` (`subscription_id`),
  KEY `event_subscription_event` (`event_id`),
  KEY `event_subscription_subscription_payment_id` (`subscription_payment_id`),
  CONSTRAINT `event_subscription_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `event_subscription_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `subscription` (`subscription_id`) ON UPDATE CASCADE,
  CONSTRAINT `event_subscription_subscription_payment_id` FOREIGN KEY (`subscription_payment_id`) REFERENCES `subscription_payment` (`subscription_payment_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_ta`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_ta` (
  `event_id` int(10) unsigned NOT NULL,
  `employee_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_ta_employee` (`employee_id`),
  CONSTRAINT `FK_event_ta_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_ta_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_token`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_token` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `token_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `FK_event_token_token` (`token_id`),
  KEY `FK_event_token_account` (`account_id`),
  KEY `index_token_name` (`token_name`),
  CONSTRAINT `FK_event_token_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_event_token_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_token_token` FOREIGN KEY (`token_id`) REFERENCES `token` (`token_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_transfer_access_right`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_transfer_access_right` (
  `event_id` int(10) unsigned NOT NULL,
  `loading_event_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`event_id`),
  KEY `FK loading_event_id` (`loading_event_id`),
  CONSTRAINT `FK event_id` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK loading_event_id` FOREIGN KEY (`loading_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_type` (
  `event_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_api`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_api` (
  `external_api_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `api_name` varchar(100) NOT NULL,
  `api_url` varchar(255) DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `auth_name` varchar(255) DEFAULT NULL,
  `auth_secret` varchar(255) DEFAULT NULL,
  `token` text,
  `token_expiration` datetime DEFAULT NULL,
  `is_production` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`external_api_id`),
  KEY `FK_external_api_organization_id` (`organization_id`),
  CONSTRAINT `FK_external_api_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fare_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare_product` (
  `fare_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fare_product_type_id` int(10) unsigned NOT NULL DEFAULT '1',
  `product_id` int(10) unsigned DEFAULT NULL,
  `access_right_template_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `name_customer` varchar(50) DEFAULT NULL,
  `customer_group_id` int(10) unsigned DEFAULT NULL,
  `vat_group_id` int(10) unsigned NOT NULL DEFAULT '2',
  `price` int(11) DEFAULT NULL,
  `price_type_id` int(10) unsigned NOT NULL DEFAULT '1',
  `shortcut` varchar(45) DEFAULT NULL,
  `sell_from_date` date DEFAULT NULL,
  `sell_until_date` date DEFAULT NULL,
  `timetable_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned NOT NULL DEFAULT '1',
  `is_validate_at_sale` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `account_number` varchar(50) DEFAULT NULL,
  `amount_for_second_vat` int(10) unsigned DEFAULT NULL,
  `second_vat_group_id` int(10) unsigned DEFAULT NULL,
  `account_number_2` varchar(50) DEFAULT NULL,
  `reservation_event_id` int(10) unsigned DEFAULT NULL,
  `reservation_event_group_id` int(10) unsigned DEFAULT NULL,
  `reservation_group_id` int(10) unsigned DEFAULT NULL,
  `is_event_price` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_printed_ticket` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_sent_to_kitchen_printer` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_account_created` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `long_name` text,
  `description` text,
  `description_2` text,
  `extra_1` text,
  `extra_2` text,
  `external_id` varchar(50) DEFAULT NULL,
  `ui_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `required_field_group_id` int(10) unsigned DEFAULT NULL,
  `is_hide_bundle_rows` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fare_product_id`),
  KEY `FK_fare_product_customer_group` (`customer_group_id`),
  KEY `FK_fare_product_vat_group` (`vat_group_id`),
  KEY `FK_fare_product_product` (`product_id`),
  KEY `FK_fare_product_access_right_template` (`access_right_template_id`),
  KEY `FK_fare_product_organization` (`organization_id`),
  KEY `FK_fare_product_type` (`fare_product_type_id`),
  KEY `FK_fare_product_price_type` (`price_type_id`),
  KEY `FK_fare_product_vat2` (`second_vat_group_id`),
  KEY `FK_fare_product_reservation_event` (`reservation_event_id`),
  KEY `FK_fare_product_reservation_event_group` (`reservation_event_group_id`),
  KEY `FK_fare_product_reservation_group` (`reservation_group_id`),
  KEY `FK_fare_product_timetable` (`timetable_id`),
  KEY `FK_fare_product_required_field_group_id` (`required_field_group_id`),
  CONSTRAINT `FK_fare_product_access_right_template` FOREIGN KEY (`access_right_template_id`) REFERENCES `access_right_template` (`access_right_template_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_customer_group` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`),
  CONSTRAINT `FK_fare_product_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_price_type` FOREIGN KEY (`price_type_id`) REFERENCES `price_type` (`price_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_fare_product_required_field_group_id` FOREIGN KEY (`required_field_group_id`) REFERENCES `field_group` (`field_group_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_reservation_event` FOREIGN KEY (`reservation_event_id`) REFERENCES `reservation_event` (`reservation_event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_reservation_event_group` FOREIGN KEY (`reservation_event_group_id`) REFERENCES `reservation_event_group` (`reservation_event_group_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_reservation_group` FOREIGN KEY (`reservation_group_id`) REFERENCES `reservation_group` (`reservation_group_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_timetable` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_type` FOREIGN KEY (`fare_product_type_id`) REFERENCES `fare_product_type` (`fare_product_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_vat2` FOREIGN KEY (`second_vat_group_id`) REFERENCES `vat_group` (`vat_group_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_vat_group` FOREIGN KEY (`vat_group_id`) REFERENCES `vat_group` (`vat_group_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fare_product_count`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare_product_count` (
  `device_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fare_product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `weekday` int(10) unsigned NOT NULL DEFAULT '0',
  `daytime` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`device_id`,`fare_product_id`,`weekday`,`daytime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fare_product_field_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare_product_field_group` (
  `fare_product_id` int(10) unsigned NOT NULL,
  `field_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`fare_product_id`,`field_group_id`),
  KEY `FK_fare_product_field_group` (`field_group_id`),
  CONSTRAINT `FK_fare_product_field_group` FOREIGN KEY (`field_group_id`) REFERENCES `field_group` (`field_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_fare_product_field_group_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fare_product_required_property`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare_product_required_property` (
  `fare_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fare_product_id`,`property_id`),
  KEY `FK_property` (`property_id`),
  CONSTRAINT `FK_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fare_product_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare_product_type` (
  `fare_product_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`fare_product_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `field_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_group_id` int(10) unsigned NOT NULL,
  `ui_order` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `field_group_id` (`field_group_id`,`name`),
  CONSTRAINT `field_group_id` FOREIGN KEY (`field_group_id`) REFERENCES `field_group` (`field_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_group` (
  `field_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`field_group_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gender`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gender` (
  `gender_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`gender_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instructor`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_event_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_given_away` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_attended` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`account_id`,`reservation_event_id`),
  KEY `FK_instructor_account_id` (`account_id`),
  KEY `FK_instructor_reservation_event_id` (`reservation_event_id`),
  CONSTRAINT `FK_instructor_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_instructor_reservation_event_id` FOREIGN KEY (`reservation_event_id`) REFERENCES `reservation_event` (`reservation_event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_batch`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_batch` (
  `inventory_batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inventory_item_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `quantity` float NOT NULL DEFAULT '0',
  `unit_cost` float unsigned DEFAULT NULL,
  PRIMARY KEY (`inventory_batch_id`),
  KEY `FK_inventory_item` (`inventory_item_id`),
  KEY `FK_location` (`location_id`),
  CONSTRAINT `FK_inventory_item` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_item` (`inventory_item_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_event_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_event_type` (
  `inventory_event_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`inventory_event_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_item`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_item` (
  `inventory_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `inventory_unit` varchar(10) DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `external_id` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `alert_quantity` int(10) unsigned DEFAULT NULL,
  `alert_email` varchar(255) DEFAULT NULL,
  `alert_subject` varchar(255) DEFAULT NULL,
  `alert_sent` datetime DEFAULT NULL,
  `alert_template_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`inventory_item_id`),
  KEY `alert_template_id` (`alert_template_id`),
  CONSTRAINT `FK_template` FOREIGN KEY (`alert_template_id`) REFERENCES `template` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_item_fare_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_item_fare_product` (
  `inventory_item_fare_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inventory_item_id` int(10) unsigned NOT NULL,
  `fare_product_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`inventory_item_fare_product_id`),
  UNIQUE KEY `inventory_item_fare_product` (`inventory_item_id`,`fare_product_id`),
  KEY `FK_inventory_item_fare_product` (`fare_product_id`),
  CONSTRAINT `FK_inventory_item_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_inventory_item_fare_product_inventory_item` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_item` (`inventory_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_property`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_property` (
  `inventory_property_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inventory_item_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  PRIMARY KEY (`inventory_property_id`),
  KEY `name` (`name`),
  KEY `value` (`value`),
  KEY `FK_inventory_variant_property_item` (`inventory_item_id`),
  CONSTRAINT `FK_inventory_property_inventory_item` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_item` (`inventory_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoice_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_organization_id` int(10) unsigned NOT NULL,
  `service_organization_id` int(10) unsigned NOT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `reference` varchar(60) DEFAULT NULL,
  `our_reference` varchar(60) DEFAULT NULL,
  `creation_timestamp` datetime DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `invoice_due_date` date DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_exported` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `invoice_status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `read_timestamp` datetime DEFAULT NULL,
  `read_user_id` int(10) unsigned DEFAULT NULL,
  `credit_invoice_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_invoice_agreement` (`agreement_id`),
  KEY `FK_invoice_customer` (`customer_organization_id`),
  KEY `FK_invoice_service` (`service_organization_id`),
  KEY `FK_invoice_status` (`invoice_status_id`),
  KEY `Index_creation_times` (`creation_timestamp`),
  KEY `Index_invoice_date` (`invoice_date`),
  KEY `FK_invoice_read_user_id` (`read_user_id`),
  KEY `credit_invoice_id` (`credit_invoice_id`),
  CONSTRAINT `FK_invoice_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_customer` FOREIGN KEY (`customer_organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_read_user_id` FOREIGN KEY (`read_user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_service` FOREIGN KEY (`service_organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_status` FOREIGN KEY (`invoice_status_id`) REFERENCES `invoice_status` (`invoice_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`credit_invoice_id`) REFERENCES `invoice` (`invoice_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_delivery_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_delivery_type` (
  `invoice_delivery_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`invoice_delivery_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_payment`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_payment` (
  `invoice_payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_payment_source_id` int(10) unsigned NOT NULL,
  `invoice_id` int(10) unsigned NOT NULL,
  `payment_amount` int(10) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `archive_number` varchar(64) DEFAULT NULL,
  `is_exported` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_payment_id`),
  KEY `FK_invoice_payment_invoice_id` (`invoice_id`),
  KEY `FK_invoice_payment_payment_source` (`invoice_payment_source_id`),
  CONSTRAINT `FK_invoice_payment_payment_source` FOREIGN KEY (`invoice_payment_source_id`) REFERENCES `invoice_payment_source` (`invoice_payment_source_id`) ON UPDATE CASCADE,
  CONSTRAINT `invoice_payment_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_payment_source`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_payment_source` (
  `invoice_payment_source_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`invoice_payment_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_row`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_row` (
  `invoice_row_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `name` text NOT NULL,
  `price` int(10) DEFAULT NULL,
  `quantity` int(10) DEFAULT NULL,
  `vat_group_id` int(10) unsigned DEFAULT NULL,
  `fare_product_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `reservation_id` int(10) unsigned DEFAULT NULL,
  `cancelled_invoice_row_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`invoice_row_id`),
  KEY `FK_invoice_row_fare_product` (`fare_product_id`),
  KEY `FK_invoice_row_invoice` (`invoice_id`),
  KEY `FK_invoice_row_vat_group` (`vat_group_id`),
  KEY `FK_invoice_row_location` (`location_id`),
  KEY `FK_invoice_row_agreement` (`agreement_id`),
  KEY `FK_invoice_row_reservation_id` (`reservation_id`),
  KEY `FK_invoice_row_cancelled_invoice_row` (`cancelled_invoice_row_id`),
  CONSTRAINT `FK_invoice_row_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_row_cancelled_invoice_row` FOREIGN KEY (`cancelled_invoice_row_id`) REFERENCES `invoice_row` (`invoice_row_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_row_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_row_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_row_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_row_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_invoice_row_vat_group` FOREIGN KEY (`vat_group_id`) REFERENCES `vat_group` (`vat_group_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_status`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_status` (
  `invoice_status_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`invoice_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoicing_period`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoicing_period` (
  `invoicing_period_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  PRIMARY KEY (`invoicing_period_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `language`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `language_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `short_name` varchar(5) NOT NULL DEFAULT '',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `last_event`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_event` (
  `access_point_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `event_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`access_point_id`,`event_type_id`),
  KEY `FK_last_event` (`event_id`),
  KEY `FK_last_event_type` (`event_type_id`),
  CONSTRAINT `FK_last_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_last_event_access_point` FOREIGN KEY (`access_point_id`) REFERENCES `access_point` (`access_point_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_last_event_type` FOREIGN KEY (`event_type_id`) REFERENCES `event_type` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `location_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `organization_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `location_receipt_header` text,
  `location_receipt_footer` text,
  `plan_path` text,
  `default_web_device_id` int(10) unsigned DEFAULT NULL,
  `address` text,
  `code` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `FK_location_default_web_device` (`default_web_device_id`),
  KEY `FK_location_organization` (`organization_id`),
  CONSTRAINT `FK_location_default_web_device` FOREIGN KEY (`default_web_device_id`) REFERENCES `device` (`device_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_location_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_payment_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_payment_type` (
  `location_payment_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(10) unsigned NOT NULL,
  `organization_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned NOT NULL,
  `merchant_id` varchar(45) DEFAULT NULL,
  `merchant_authcode` varchar(90) DEFAULT NULL,
  `override_account_no` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`location_payment_type_id`),
  KEY `location_payment_type_location` (`location_id`),
  KEY `location_payment_type_organization_id` (`organization_id`),
  KEY `location_payment_type` (`payment_type_id`),
  CONSTRAINT `location_payment_type` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `location_payment_type_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `location_payment_type_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locker`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locker` (
  `locker_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(10) unsigned NOT NULL,
  `resource_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_battery_low` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `token_id` int(10) unsigned DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  PRIMARY KEY (`locker_id`),
  UNIQUE KEY `location_number` (`location_id`,`number`),
  KEY `FK_locker_resource` (`resource_id`),
  KEY `FK_locker_token` (`token_id`),
  CONSTRAINT `FK_locker_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_locker_resource` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_locker_token` FOREIGN KEY (`token_id`) REFERENCES `token` (`token_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_level_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `device_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `path` varchar(100) DEFAULT NULL,
  `message` text CHARACTER SET latin1,
  `json` text CHARACTER SET latin1,
  `backtrace` text,
  `execution_time` float DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_timestamp` (`timestamp`),
  KEY `log_path` (`path`),
  KEY `log_user_id` (`user_id`),
  KEY `log_device_id` (`device_id`,`timestamp`),
  KEY `log_device_message` (`message`(100)),
  KEY `log_level_id` (`log_level_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_level`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_level` (
  `log_level_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`log_level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `url` text NOT NULL,
  `hash` varchar(45) NOT NULL DEFAULT '',
  `network_address` varchar(45) DEFAULT NULL,
  `expiration` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`login_id`),
  KEY `FK_login_user` (`user_id`),
  CONSTRAINT `FK_login_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_type_id` int(10) unsigned NOT NULL,
  `recipient_user_id` int(10) unsigned DEFAULT NULL,
  `originator` varchar(45) DEFAULT NULL,
  `subject` varchar(45) DEFAULT NULL,
  `body` text,
  `email` varchar(256) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`message_id`),
  KEY `FK_message_type_id` (`message_type_id`),
  KEY `FK_recipient_user_id` (`recipient_user_id`),
  CONSTRAINT `FK_message_type_id` FOREIGN KEY (`message_type_id`) REFERENCES `message_type` (`message_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_recipient_user_id` FOREIGN KEY (`recipient_user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_status`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_status` (
  `message_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`message_status_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_type` (
  `message_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`message_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `module`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `module_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `note_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `object_name` varchar(45) DEFAULT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`note_id`),
  KEY `index_note` (`timestamp`),
  KEY `index_object_id` (`object_id`),
  KEY `index_object_name` (`object_name`),
  KEY `index_object_name_id_name_timestamp` (`object_name`,`object_id`,`name`,`timestamp`),
  KEY `index_name` (`name`),
  KEY `FK_location_id` (`location_id`),
  CONSTRAINT `FK_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `creation_date` datetime NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `buyer_account_id` int(10) unsigned NOT NULL,
  `delivery_address` text,
  `delivery_type_id` int(10) unsigned NOT NULL DEFAULT '1',
  `order_status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `info` text,
  `is_subtraction` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  KEY `order_status` (`order_status_id`),
  KEY `order_delivery_type` (`delivery_type_id`),
  KEY `order_buyer_account` (`buyer_account_id`),
  CONSTRAINT `order_buyer_account` FOREIGN KEY (`buyer_account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_delivery_type` FOREIGN KEY (`delivery_type_id`) REFERENCES `delivery_type` (`delivery_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_status` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_status`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_status` (
  `order_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `organization_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `department` varchar(50) DEFAULT NULL,
  `address` text,
  `country_code` varchar(45) DEFAULT NULL,
  `domicile` varchar(45) DEFAULT NULL,
  `info` text,
  `business_id` varchar(45) DEFAULT NULL,
  `foreign_business_id` varchar(45) DEFAULT NULL,
  `foreign_business_id_type` tinyint(1) unsigned DEFAULT NULL,
  `external_id` varchar(50) DEFAULT NULL,
  `is_agent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_customer_organization` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_invoicing_allowed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `logo_url` text,
  `logo2_url` text,
  `organization_receipt_header` text,
  `organization_receipt_footer` text,
  `default_web_device_id` int(10) unsigned DEFAULT NULL,
  `bank_account_number` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `iban` text,
  `bic` text,
  `invoice_row_grouping` varchar(255) DEFAULT NULL,
  `invoice_footer` text,
  `electronic_invoicing_address` varchar(20) DEFAULT NULL,
  `is_vat_exported` tinyint(1) unsigned DEFAULT '1',
  `invoice_delivery_type_id` int(10) unsigned DEFAULT NULL,
  `customership_start_date` date DEFAULT NULL,
  `customership_end_date` date DEFAULT NULL,
  `payment_terms_days` int(10) unsigned DEFAULT NULL,
  `accounting_integration_class_name` varchar(45) DEFAULT NULL,
  `invoicing_integration_class_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`organization_id`),
  KEY `FK_organization_device` (`default_web_device_id`),
  KEY `FK_organization_invoice_delivery_type` (`invoice_delivery_type_id`),
  CONSTRAINT `FK_organization_device` FOREIGN KEY (`default_web_device_id`) REFERENCES `device` (`device_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_organization_invoice_delivery_type` FOREIGN KEY (`invoice_delivery_type_id`) REFERENCES `invoice_delivery_type` (`invoice_delivery_type_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_payment_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_payment_type` (
  `organization_payment_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL DEFAULT '0',
  `payment_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `ui_order` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `is_drawer_kicked_out` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `return_duration` int(10) unsigned NOT NULL DEFAULT '86400',
  `override_account_no` varchar(45) DEFAULT NULL,
  `merchant_id` varchar(45) DEFAULT NULL,
  `merchant_authcode` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`organization_payment_type_id`),
  UNIQUE KEY `Index_unique` (`organization_id`,`payment_type_id`),
  KEY `FK_organization_payment_type_key` (`payment_type_id`),
  KEY `FK_organization_payment_type_organization_id` (`organization_id`),
  CONSTRAINT `FK_organization_payment_type_key` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_organization_payment_type_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organization_payment_type_field_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization_payment_type_field_group` (
  `organization_payment_type_id` int(10) unsigned NOT NULL,
  `field_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`organization_payment_type_id`,`field_group_id`),
  KEY `FK_fare_product_field_group` (`field_group_id`),
  CONSTRAINT `FK_field_group_organization_payment_type` FOREIGN KEY (`organization_payment_type_id`) REFERENCES `organization_payment_type` (`organization_payment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_organization_payment_type_field_group` FOREIGN KEY (`field_group_id`) REFERENCES `field_group` (`field_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parameter`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parameter` (
  `parameter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `module_id` int(10) unsigned NOT NULL DEFAULT '0',
  `device_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`parameter_id`),
  UNIQUE KEY `Index_name` (`name`,`module_id`,`device_id`),
  KEY `FK_parameter_device_id` (`device_id`),
  KEY `FK_parameter_module_id` (`module_id`),
  CONSTRAINT `FK_parameter_device_id` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_parameter_module_id` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parameter_description`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parameter_description` (
  `parameter_description_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `description` mediumtext,
  `value_type` varchar(50) NOT NULL DEFAULT 'text' COMMENT 'types from Field.php',
  `is_user_configurable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`parameter_description_id`),
  UNIQUE KEY `name` (`name`,`module_id`),
  KEY `FK_parameter_description_module` (`module_id`),
  CONSTRAINT `FK_parameter_description_module` FOREIGN KEY (`module_id`) REFERENCES `module` (`module_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2373 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_class`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_class` (
  `payment_class_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`payment_class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_type` (
  `payment_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `account_number` varchar(45) DEFAULT NULL,
  `payment_class_id` int(10) unsigned NOT NULL DEFAULT '1',
  `class_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`payment_type_id`),
  KEY `FK_payment_type_class` (`payment_class_id`),
  CONSTRAINT `FK_payment_type_class` FOREIGN KEY (`payment_class_id`) REFERENCES `payment_class` (`payment_class_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `phinx_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phinx_log` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pk_receipt`
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pk_receipt` (
  `pk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receipt_event_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pk_id`,`receipt_event_id`),
  KEY `FK_pk_receipt_event` (`receipt_event_id`),
  CONSTRAINT `FK_pk_receipt_event` FOREIGN KEY (`receipt_event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_change`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_change` (
  `price_change_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `price_change_set_id` int(10) unsigned NOT NULL,
  `fare_product_id` int(10) unsigned NOT NULL,
  `old_price` int(10) unsigned DEFAULT NULL,
  `new_price` int(10) unsigned NOT NULL,
  PRIMARY KEY (`price_change_id`),
  UNIQUE KEY `Index_unique_fp` (`price_change_set_id`,`fare_product_id`),
  KEY `FK_price_change_fare_product` (`fare_product_id`),
  CONSTRAINT `FK_price_change_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_price_change_set` FOREIGN KEY (`price_change_set_id`) REFERENCES `price_change_set` (`price_change_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_change_set`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_change_set` (
  `price_change_set_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `change_date` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`price_change_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_type` (
  `price_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`price_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `service_group_id` int(10) unsigned NOT NULL DEFAULT '7',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`),
  KEY `FK_product_service_group` (`service_group_id`),
  CONSTRAINT `FK_product_service_group` FOREIGN KEY (`service_group_id`) REFERENCES `service_group` (`service_group_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `property_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `property_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `label` text,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  KEY `FK_property_group` (`property_group_id`),
  CONSTRAINT `FK_property_group` FOREIGN KEY (`property_group_id`) REFERENCES `property_group` (`property_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_group` (
  `property_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`property_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raw_batch`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raw_batch` (
  `raw_batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`raw_batch_id`),
  KEY `FK_raw_batch_organization` (`organization_id`),
  CONSTRAINT `FK_raw_batch_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raw_data`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raw_data` (
  `raw_data_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `raw_batch_id` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`raw_data_id`),
  KEY `FK_raw_data_batch` (`raw_batch_id`),
  CONSTRAINT `FK_raw_data_batch` FOREIGN KEY (`raw_batch_id`) REFERENCES `raw_batch` (`raw_batch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rbac_permission`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_permission` (
  `rbac_permission_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`rbac_permission_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rbac_role`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role` (
  `rbac_role_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`rbac_role_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rbac_role_link`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role_link` (
  `parent_role_id` int(10) unsigned NOT NULL,
  `child_role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`parent_role_id`,`child_role_id`),
  KEY `rbac_role_child` (`child_role_id`),
  CONSTRAINT `rbac_role_child` FOREIGN KEY (`child_role_id`) REFERENCES `rbac_role` (`rbac_role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rbac_role_parent` FOREIGN KEY (`parent_role_id`) REFERENCES `rbac_role` (`rbac_role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rbac_role_permission`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_role_permission` (
  `rbac_role_id` int(10) unsigned NOT NULL,
  `rbac_permission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`rbac_role_id`,`rbac_permission_id`),
  KEY `rbac_role_permission` (`rbac_permission_id`),
  CONSTRAINT `rbac_role_permission` FOREIGN KEY (`rbac_permission_id`) REFERENCES `rbac_permission` (`rbac_permission_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rbac_role_permission_role` FOREIGN KEY (`rbac_role_id`) REFERENCES `rbac_role` (`rbac_role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rbac_user_role`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rbac_user_role` (
  `user_id` int(10) unsigned NOT NULL,
  `rbac_role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`rbac_role_id`),
  KEY `rbac_user_role` (`rbac_role_id`),
  CONSTRAINT `rbac_user_role` FOREIGN KEY (`rbac_role_id`) REFERENCES `rbac_role` (`rbac_role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rbac_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `reservation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_event_id` int(10) unsigned NOT NULL DEFAULT '0',
  `reservation_account_id` int(10) unsigned NOT NULL DEFAULT '0',
  `reservation_timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reservation_status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `reserving_user_id` int(10) unsigned DEFAULT NULL,
  `sale_event_id` int(10) unsigned DEFAULT NULL,
  `is_for_sale` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_paid` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `cancellation_warning_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `FK_reservation_event` (`reservation_event_id`),
  KEY `FK_reservation_account` (`reservation_account_id`),
  KEY `FK_reservation_status` (`reservation_status_id`),
  KEY `FK_reservation_sale_event` (`sale_event_id`),
  KEY `FK_reserving_user_id` (`reserving_user_id`),
  CONSTRAINT `FK_reservation_account` FOREIGN KEY (`reservation_account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_event` FOREIGN KEY (`reservation_event_id`) REFERENCES `reservation_event` (`reservation_event_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_sale_event` FOREIGN KEY (`sale_event_id`) REFERENCES `event` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_status` FOREIGN KEY (`reservation_status_id`) REFERENCES `reservation_status` (`reservation_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_reserving_user_id` FOREIGN KEY (`reserving_user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_event`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_event` (
  `reservation_event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_event_group_id` int(10) unsigned DEFAULT NULL,
  `service_at_area_id` int(10) unsigned DEFAULT NULL,
  `owner_account_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `capacity` int(10) unsigned NOT NULL DEFAULT '1',
  `queue_capacity` int(10) unsigned NOT NULL DEFAULT '0',
  `web_limit` int(10) unsigned DEFAULT NULL,
  `quantity_attended` int(10) unsigned NOT NULL DEFAULT '0',
  `time_start` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_end` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `duration_before_start` int(10) unsigned DEFAULT NULL,
  `duration_after_start` int(10) unsigned DEFAULT NULL,
  `is_auto_reservation_allowed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_auto_validated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_ownership_open` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `max_instructor_quantity` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`reservation_event_id`),
  KEY `FK_reservation_event_group` (`reservation_event_group_id`),
  KEY `FK_reservation_event_service_at_area` (`service_at_area_id`),
  KEY `FK_reservation_event_account` (`owner_account_id`),
  KEY `time_start` (`time_start`),
  CONSTRAINT `FK_reservation_event_group` FOREIGN KEY (`reservation_event_group_id`) REFERENCES `reservation_event_group` (`reservation_event_group_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_event_owner` FOREIGN KEY (`owner_account_id`) REFERENCES `account` (`account_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_event_service_at_area` FOREIGN KEY (`service_at_area_id`) REFERENCES `service_at_area` (`service_at_area_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_event_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_event_group` (
  `reservation_event_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `reservation_group_id` int(10) unsigned DEFAULT NULL,
  `description` text,
  `description_long` text,
  `description_form` text,
  `public_reservation_start` datetime DEFAULT NULL,
  `public_reservation_end` datetime DEFAULT NULL,
  `public_visibility_start` datetime DEFAULT NULL,
  `public_visibility_end` datetime DEFAULT NULL,
  `instructor_visibility_start` datetime DEFAULT NULL,
  `instructor_visibility_end` datetime DEFAULT NULL,
  `is_dob_required_for_reservation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`reservation_event_group_id`),
  KEY `FK_reservation_event_group_group` (`reservation_group_id`),
  CONSTRAINT `FK_reservation_event_group_group` FOREIGN KEY (`reservation_group_id`) REFERENCES `reservation_group` (`reservation_group_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_event_group_fare_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_event_group_fare_product` (
  `reservation_event_group_id` int(10) unsigned NOT NULL,
  `fare_product_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`reservation_event_group_id`,`fare_product_id`),
  KEY `FK_reservation_event_group_fare_product_fare_product` (`fare_product_id`),
  CONSTRAINT `FK_reservation_event_group_fare_product_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_event_group_fare_product_reservation_event_group` FOREIGN KEY (`reservation_event_group_id`) REFERENCES `reservation_event_group` (`reservation_event_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_event_group_tag_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_event_group_tag_group` (
  `reservation_event_group_tag_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_event_group_id` int(10) unsigned NOT NULL,
  `tag_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`reservation_event_group_tag_group_id`),
  KEY `FK_reservation_event_group` (`tag_group_id`),
  KEY `FK_reservation_event_group_tag_group_reservation_event_group` (`reservation_event_group_id`),
  CONSTRAINT `FK_reservation_event_group_tag_group` FOREIGN KEY (`tag_group_id`) REFERENCES `tag_group` (`tag_group_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_event_group_tag_group_reservation_event_group` FOREIGN KEY (`reservation_event_group_id`) REFERENCES `reservation_event_group` (`reservation_event_group_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_event_resource`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_event_resource` (
  `reservation_event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_used` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`reservation_event_id`,`resource_id`),
  KEY `FK_reservation_event_resource` (`resource_id`),
  CONSTRAINT `FK_reservation_event_id` FOREIGN KEY (`reservation_event_id`) REFERENCES `reservation_event` (`reservation_event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_reservation_event_resource` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_group` (
  `reservation_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `is_course` tinyint(1) unsigned NOT NULL,
  `is_reserve_remaining` tinyint(1) unsigned NOT NULL,
  `achievements` text,
  `send_email_on_reservation_to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reservation_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_group_required_property`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_group_required_property` (
  `reservation_group_required_property_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_group_id` int(10) unsigned NOT NULL,
  `property_id` int(10) unsigned NOT NULL,
  `is_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `question` text,
  PRIMARY KEY (`reservation_group_required_property_id`),
  UNIQUE KEY `reg_property` (`reservation_group_id`,`property_id`),
  KEY `property` (`property_id`),
  CONSTRAINT `property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON UPDATE CASCADE,
  CONSTRAINT `reservation_group` FOREIGN KEY (`reservation_group_id`) REFERENCES `reservation_group` (`reservation_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation_status`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_status` (
  `reservation_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`reservation_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource` (
  `resource_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_group_id` smallint(5) unsigned DEFAULT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `short_name` varchar(45) DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `gender_id` tinyint(3) unsigned DEFAULT NULL,
  `max_quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `is_hidden_in_pos` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ui_order` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text,
  `is_pay_now` tinyint(1) NOT NULL DEFAULT '1',
  `is_pay_later` tinyint(1) NOT NULL DEFAULT '0',
  `account_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`resource_id`),
  KEY `FK_resource_gender` (`gender_id`),
  KEY `FK_resource_location` (`location_id`),
  KEY `FK_resource_account` (`account_id`),
  KEY `FK_resource_group` (`resource_group_id`),
  CONSTRAINT `FK_resource_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_resource_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`gender_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_resource_group` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`resource_group_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_resource_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_fare_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_fare_product` (
  `resource_id` int(10) unsigned NOT NULL,
  `fare_product_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`resource_id`,`fare_product_id`),
  KEY `FK_resource_fare_product` (`fare_product_id`),
  CONSTRAINT `FK_resource_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_resource_fare_product_resource` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_group` (
  `resource_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `description` text,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_link`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_link` (
  `source_resource_id` int(10) unsigned NOT NULL DEFAULT '0',
  `target_resource_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`source_resource_id`,`target_resource_id`),
  KEY `FK_resource_link_2` (`target_resource_id`),
  CONSTRAINT `FK_resource_link_1` FOREIGN KEY (`source_resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_resource_link_2` FOREIGN KEY (`target_resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resource_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_type` (
  `resource_type_id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`resource_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `route`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salary_rate`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salary_rate` (
  `salary_rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salary_rate` int(10) unsigned NOT NULL,
  PRIMARY KEY (`salary_rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sale_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_group` (
  `sale_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `name_customer` varchar(100) DEFAULT NULL,
  `ui_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `description` text,
  `send_email_on_sale_to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sale_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sale_group_row`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_group_row` (
  `sale_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fare_product_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_group_id`,`fare_product_id`),
  KEY `FK_sale_group_row_fare_product` (`fare_product_id`),
  CONSTRAINT `FK_sale_group_row_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_sale_group_row_sale_group` FOREIGN KEY (`sale_group_id`) REFERENCES `sale_group` (`sale_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `shortcut` varchar(45) DEFAULT NULL,
  `description` text,
  `image_id` varchar(255) DEFAULT NULL,
  `is_simple_registration_allowed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ui_order` int(10) unsigned NOT NULL DEFAULT '0',
  `ui_type` varchar(45) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `Index_shortcut` (`shortcut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_at_area`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_at_area` (
  `service_at_area_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_area_id` int(10) unsigned NOT NULL DEFAULT '0',
  `service_id` int(10) unsigned NOT NULL DEFAULT '0',
  `organization_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_reservation_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `time_offset_duration` int(10) unsigned NOT NULL DEFAULT '0',
  `time_slot_duration` int(10) unsigned NOT NULL DEFAULT '0',
  `resource_reservation_timetable_id` int(10) unsigned DEFAULT NULL,
  `duration_before_start` int(10) unsigned NOT NULL DEFAULT '2700',
  `duration_after_start` int(10) unsigned NOT NULL DEFAULT '0',
  `is_access_until_end` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `public_reservation_start` datetime DEFAULT NULL,
  `public_reservation_end` datetime DEFAULT NULL,
  `public_visibility_start` datetime DEFAULT NULL,
  `public_visibility_end` datetime DEFAULT NULL,
  `instructor_visibility_start` datetime DEFAULT NULL,
  `instructor_visibility_end` datetime DEFAULT NULL,
  `is_missed_event_warning_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_at_area_id`),
  KEY `FK_service_at_area_access_area_id` (`access_area_id`),
  KEY `FK_service_at_area_service_id` (`service_id`),
  KEY `FK_service_at_area_organization_id` (`organization_id`),
  KEY `FK_timetable_id` (`resource_reservation_timetable_id`),
  CONSTRAINT `FK_service_at_area_access_area` FOREIGN KEY (`access_area_id`) REFERENCES `access_area` (`access_area_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_service_at_area_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_service_at_area_service` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_timetable_id` FOREIGN KEY (`resource_reservation_timetable_id`) REFERENCES `timetable` (`timetable_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_at_area_resource`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_at_area_resource` (
  `service_at_area_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_required_for_reservation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_at_area_id`,`resource_id`),
  KEY `FK_service_at_area_resource_resource_id` (`resource_id`),
  CONSTRAINT `FK_service_at_area_resource_resource` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_service_at_area_resource_service_at_area` FOREIGN KEY (`service_at_area_id`) REFERENCES `service_at_area` (`service_at_area_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_group` (
  `service_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `name_customer` varchar(45) DEFAULT NULL,
  `ui_order` int(10) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `description` text,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`service_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_group_row`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_group_row` (
  `service_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_at_area_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_prevalidation_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_prioritized` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_group_id`,`service_at_area_id`),
  KEY `FK_service_group_row_service_at_area_id` (`service_at_area_id`),
  CONSTRAINT `FK_service_group_row_service_at_area` FOREIGN KEY (`service_at_area_id`) REFERENCES `service_at_area` (`service_at_area_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_service_group_row_service_group` FOREIGN KEY (`service_group_id`) REFERENCES `service_group` (`service_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shared_quantity`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_quantity` (
  `shared_quantity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`shared_quantity_id`),
  KEY `FK_shared_quantity_agreement` (`agreement_id`),
  CONSTRAINT `FK_shared_quantity_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `subscription_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agreement_id` int(10) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `invoicing_period_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `last_sale_date` date DEFAULT NULL,
  `on_hold_start` date DEFAULT NULL,
  `on_hold_end` date DEFAULT NULL,
  `is_on_hold` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_access_right_disabled_when_on_hold` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subscription_invoicing_type_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  KEY `subscription_agreement` (`agreement_id`),
  KEY `subscription_invoicing_period` (`invoicing_period_id`),
  KEY `FK_subscription_invoicing_type_id` (`subscription_invoicing_type_id`),
  CONSTRAINT `FK_subscription_invoicing_type_id` FOREIGN KEY (`subscription_invoicing_type_id`) REFERENCES `subscription_invoicing_type` (`subscription_invoicing_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `subscription_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON UPDATE CASCADE,
  CONSTRAINT `subscription_invoicing_period` FOREIGN KEY (`invoicing_period_id`) REFERENCES `invoicing_period` (`invoicing_period_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_fare_product`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_fare_product` (
  `subscription_id` int(10) unsigned NOT NULL,
  `fare_product_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`subscription_id`,`fare_product_id`),
  KEY `FK_subscription_fare_product_subscription_id` (`subscription_id`),
  KEY `FK_subscription_fare_product_fare_product_id` (`fare_product_id`),
  CONSTRAINT `FK_subscription_fare_product_fare_product_id` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_subscription_fare_product_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscription` (`subscription_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_invoicing_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_invoicing_type` (
  `subscription_invoicing_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`subscription_invoicing_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subscription_payment`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_payment` (
  `subscription_payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` int(10) unsigned NOT NULL DEFAULT '0',
  `agreement_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fare_product_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fare_product_name` varchar(50) DEFAULT NULL,
  `quantity` int(10) DEFAULT '1',
  `payment_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `amount` int(11) DEFAULT NULL,
  `text` text,
  `is_access_right_loaded` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`subscription_payment_id`),
  KEY `FK_subscription_payment_subscription_id` (`subscription_id`),
  KEY `FK_subscription_payment_agreement_id` (`agreement_id`),
  KEY `FK_subscription_payment_fare_product_id` (`fare_product_id`),
  KEY `FK_subscription_payment_payment_type_id` (`payment_type_id`),
  CONSTRAINT `FK_subscription_payment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_subscription_payment_fare_product_id` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_subscription_payment_payment_type_id` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_subscription_payment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscription` (`subscription_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `system_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url` text,
  `local_url` text,
  PRIMARY KEY (`system_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_calendar`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_calendar` (
  `ta_calendar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`ta_calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_rule`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_rule` (
  `ta_rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `time_start_1` time DEFAULT NULL,
  `time_start_2` time DEFAULT NULL,
  `time_end_1` time DEFAULT NULL,
  `time_end_2` time DEFAULT NULL,
  `is_flexible_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `regular_time` int(10) unsigned NOT NULL,
  `ta_calendar_id` int(10) unsigned DEFAULT NULL,
  `is_zero_regular_time_on_absence` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subtract_lunch_after_time` int(10) unsigned NOT NULL DEFAULT '0',
  `lunch_duration` int(10) unsigned NOT NULL DEFAULT '1800',
  `smoking_break_duration` int(10) unsigned NOT NULL DEFAULT '1200',
  `is_strict_time_range` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `regular_time_start` time DEFAULT NULL,
  `regular_time_end` time DEFAULT NULL,
  `max_weekly_extra_time` int(10) unsigned NOT NULL DEFAULT '9000',
  PRIMARY KEY (`ta_rule_id`),
  KEY `FK_ta_rule_ta_calendar` (`ta_calendar_id`),
  CONSTRAINT `FK_ta_rule_ta_calendar` FOREIGN KEY (`ta_calendar_id`) REFERENCES `ta_calendar` (`ta_calendar_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_rule_workdays`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_rule_workdays` (
  `ta_rule_id` int(10) unsigned NOT NULL,
  `day_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ta_rule_id`,`day_type_id`),
  KEY `FK_ta_rule_workdays_day_type_id` (`day_type_id`),
  CONSTRAINT `FK_ta_rule_workdays_day_type` FOREIGN KEY (`day_type_id`) REFERENCES `day_type` (`day_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ta_rule_workdays_ta_rule_id` FOREIGN KEY (`ta_rule_id`) REFERENCES `ta_rule` (`ta_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_shift`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_shift` (
  `ta_shift_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `shift_ta_status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `regular_time` int(10) unsigned NOT NULL,
  `time_start_1` time DEFAULT NULL,
  `time_start_2` time DEFAULT NULL,
  `time_end_1` time DEFAULT NULL,
  `time_end_2` time DEFAULT NULL,
  `is_automatic` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ta_calendar_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ta_shift_id`),
  UNIQUE KEY `index_employee_date` (`employee_id`,`date`),
  KEY `FK_ta_shift_status` (`shift_ta_status_id`),
  KEY `FK_ta_shift_ta_calendar` (`ta_calendar_id`),
  KEY `index_date` (`date`),
  KEY `FK_ta_shift_location_id` (`location_id`),
  CONSTRAINT `FK_ta_shift_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ta_shift_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ta_shift_status` FOREIGN KEY (`shift_ta_status_id`) REFERENCES `ta_status` (`ta_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ta_shift_ta_calendar` FOREIGN KEY (`ta_calendar_id`) REFERENCES `ta_calendar` (`ta_calendar_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_shift_balance`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_shift_balance` (
  `ta_shift_balance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ta_shift_id` int(10) unsigned NOT NULL,
  `ta_time_type_id` int(10) unsigned NOT NULL,
  `balance` int(11) NOT NULL,
  `is_automatic` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_cumulative` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ta_shift_balance_id`),
  KEY `FK_ta_shift_balance_shift` (`ta_shift_id`),
  KEY `FK_ta_shift_balance_time_type` (`ta_time_type_id`),
  CONSTRAINT `FK_ta_shift_balance_shift` FOREIGN KEY (`ta_shift_id`) REFERENCES `ta_shift` (`ta_shift_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ta_shift_balance_time_type` FOREIGN KEY (`ta_time_type_id`) REFERENCES `ta_time_type` (`ta_time_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_status`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_status` (
  `ta_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`ta_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_time_class`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_time_class` (
  `ta_time_class_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`ta_time_class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ta_time_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ta_time_type` (
  `ta_time_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `compensation_percentage` float NOT NULL,
  `short_name` varchar(10) NOT NULL,
  `ta_time_class_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ta_time_type_id`),
  KEY `FK_ta_time_type_class` (`ta_time_class_id`),
  CONSTRAINT `FK_ta_time_type_class` FOREIGN KEY (`ta_time_class_id`) REFERENCES `ta_time_class` (`ta_time_class_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `tag_group_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `FK_tag_group` (`tag_group_id`),
  CONSTRAINT `FK_tag_group` FOREIGN KEY (`tag_group_id`) REFERENCES `tag_group` (`tag_group_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_group` (
  `tag_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`tag_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `body` text,
  `is_using_header` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_using_footer` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `test_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `garbage` varchar(45) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `password` varchar(45) DEFAULT NULL,
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `amount` int(10) unsigned NOT NULL DEFAULT '0',
  `decimal` decimal(9,3) NOT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_slot`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_slot` (
  `time_slot_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timetable_id` int(10) unsigned NOT NULL,
  `day_type_id` int(10) unsigned NOT NULL,
  `time_start` time NOT NULL DEFAULT '00:00:00',
  `time_end` time NOT NULL DEFAULT '24:00:00',
  PRIMARY KEY (`time_slot_id`),
  KEY `FK_time_slot_timetable` (`timetable_id`),
  KEY `FK_time_slot_day_type` (`day_type_id`),
  CONSTRAINT `FK_time_slot_day_type` FOREIGN KEY (`day_type_id`) REFERENCES `day_type` (`day_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_time_slot_timetable` FOREIGN KEY (`timetable_id`) REFERENCES `timetable` (`timetable_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_slot_access_mode`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_slot_access_mode` (
  `time_slot_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_mode_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`time_slot_id`),
  KEY `FK_access_mode` (`access_mode_id`),
  CONSTRAINT `FK_access_mode` FOREIGN KEY (`access_mode_id`) REFERENCES `access_mode` (`access_mode_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_time_slot` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`time_slot_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timetable`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable` (
  `timetable_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`timetable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `token_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_blacklisted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `account_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned NOT NULL DEFAULT '0',
  `deposit_sale_id` int(10) unsigned DEFAULT NULL,
  `access_right_id` int(10) unsigned DEFAULT NULL,
  `external_id` varchar(50) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `name` (`name`,`token_type_id`),
  KEY `FK_token_token_type_id` (`token_type_id`),
  KEY `FK_token_account_id` (`account_id`),
  KEY `FK_token_organization` (`organization_id`),
  KEY `FK_token_sale_event_id` (`deposit_sale_id`),
  KEY `FK_token_access_right` (`access_right_id`),
  KEY `index_external_id` (`external_id`),
  CONSTRAINT `FK_token_access_right` FOREIGN KEY (`access_right_id`) REFERENCES `access_right` (`access_right_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_token_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE SET NULL,
  CONSTRAINT `FK_token_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_token_sale_event_id` FOREIGN KEY (`deposit_sale_id`) REFERENCES `event_sale` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_token_token_type_id` FOREIGN KEY (`token_type_id`) REFERENCES `token_type` (`token_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_type` (
  `token_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`token_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token_whitelist`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_whitelist` (
  `token_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_point_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_allowed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `expiration_date` date NOT NULL DEFAULT '0000-00-00',
  `last_update` datetime DEFAULT NULL,
  `is_collectable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `message` text,
  `data` text,
  `pin` varchar(32) DEFAULT NULL,
  `is_inside` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `do_send` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`token_id`,`access_point_id`),
  KEY `Index_access_point` (`access_point_id`),
  KEY `index_access_point_last_update` (`access_point_id`,`last_update`),
  KEY `index_access_point_do_send` (`access_point_id`,`do_send`),
  CONSTRAINT `FK_token_whitelist_access_point` FOREIGN KEY (`access_point_id`) REFERENCES `access_point` (`access_point_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_token_whitelist_token` FOREIGN KEY (`token_id`) REFERENCES `token` (`token_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `translation`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translation` (
  `translation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `translation` text,
  `is_custom` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`translation_id`),
  UNIQUE KEY `Index_language_code` (`language_id`,`name`),
  CONSTRAINT `FK_translation_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17090 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_button`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_button` (
  `ts_button_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts_product_layout_id` int(10) unsigned NOT NULL,
  `button_number` varchar(10) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `fare_product_id` int(10) unsigned DEFAULT NULL,
  `agreement_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ts_button_id`),
  KEY `FK_ts_button_agreement` (`agreement_id`),
  KEY `FK_ts_button_fare_product` (`fare_product_id`),
  KEY `FK_ts_button_product_layout` (`ts_product_layout_id`),
  CONSTRAINT `FK_ts_button_agreement` FOREIGN KEY (`agreement_id`) REFERENCES `agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ts_button_fare_product` FOREIGN KEY (`fare_product_id`) REFERENCES `fare_product` (`fare_product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ts_button_product_layout` FOREIGN KEY (`ts_product_layout_id`) REFERENCES `ts_product_layout` (`ts_product_layout_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_device_layout`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_device_layout` (
  `ts_device_layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts_product_layout_id` int(10) unsigned NOT NULL,
  `ui_order` varchar(45) NOT NULL DEFAULT '0',
  `device_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ts_device_layout_id`),
  KEY `FK_ts_device_layout_device` (`device_id`),
  KEY `FK_ts_device_layout_product` (`ts_product_layout_id`),
  CONSTRAINT `FK_ts_device_layout_device` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ts_device_layout_product` FOREIGN KEY (`ts_product_layout_id`) REFERENCES `ts_product_layout` (`ts_product_layout_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_product_layout`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_product_layout` (
  `ts_product_layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts_visual_layout_id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `short_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ts_product_layout_id`),
  KEY `FK_ts_product_layout_visual` (`ts_visual_layout_id`),
  CONSTRAINT `FK_ts_product_layout_visual` FOREIGN KEY (`ts_visual_layout_id`) REFERENCES `ts_visual_layout` (`ts_visual_layout_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ts_visual_layout`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ts_visual_layout` (
  `ts_visual_layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `rows` int(10) unsigned NOT NULL,
  `columns` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ts_visual_layout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `first_name` varchar(45) DEFAULT NULL,
  `middle_names` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `organization_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `last_seen` datetime DEFAULT NULL,
  `language_id` int(10) unsigned NOT NULL DEFAULT '1',
  `phone_number` varchar(45) DEFAULT NULL,
  `address` text,
  `country_code` varchar(45) DEFAULT NULL,
  `home_address` text,
  `home_country_code` varchar(45) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `social_security_number` varchar(45) DEFAULT NULL,
  `is_email_allowed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `notes` text,
  `notes_customer` text,
  `external_id` varchar(50) DEFAULT NULL,
  `tax_number` varchar(12) DEFAULT NULL,
  `is_in_tax_register` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tax_number_check_timestamp` datetime DEFAULT NULL,
  `picture_filename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_user_organization` (`organization_id`),
  KEY `FK_user_user_type` (`user_type_id`),
  KEY `FK_user_language_id` (`language_id`),
  KEY `index_username` (`username`),
  KEY `index_external_id` (`external_id`),
  KEY `index_name` (`name`),
  KEY `index_email` (`email`(255)),
  CONSTRAINT `FK_user_language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_user_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_user_user_type` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1695 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_auth`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth` (
  `user_auth_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `auth_code` varchar(255) DEFAULT '',
  `token` varchar(255) DEFAULT '',
  `auth_provider_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_auth_id`),
  KEY `user_auth_provider` (`auth_provider_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_auth_provider` FOREIGN KEY (`auth_provider_id`) REFERENCES `auth_provider` (`auth_provider_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_auth_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_email`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email` (
  `user_email_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL DEFAULT '',
  `email` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_email_id`),
  KEY `FK_user_email_user` (`user_id`),
  KEY `Index_email` (`email`(255)),
  CONSTRAINT `FK_user_email_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_location`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_location` (
  `user_location_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `administrative_area_level_1` varchar(100) DEFAULT NULL,
  `administrative_area_level_2` varchar(100) DEFAULT NULL,
  `administrative_area_level_3` varchar(100) DEFAULT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `sublocality` varchar(100) DEFAULT NULL,
  `postal_code` varchar(100) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `source_address` text,
  `formatted_address` text,
  PRIMARY KEY (`user_location_id`),
  KEY `FK_user_location_user` (`user_id`),
  KEY `Index_country` (`country`),
  KEY `Index_locality` (`locality`),
  KEY `Index_postal_code` (`postal_code`),
  KEY `Index_sublocality` (`sublocality`),
  KEY `Index_administrative_area_level_1` (`administrative_area_level_1`),
  KEY `Index_administrative_area_level_2` (`administrative_area_level_2`),
  KEY `Index_administrative_area_level_3` (`administrative_area_level_3`),
  CONSTRAINT `FK_user_location_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_parameter`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_parameter` (
  `user_parameter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`user_parameter_id`),
  UNIQUE KEY `Index_2` (`user_id`,`name`),
  CONSTRAINT `FK_user_parameter_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_statistic`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_statistic` (
  `user_statistic_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `year` year(4) NOT NULL,
  `event_type_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `service_at_area_id` int(10) DEFAULT NULL,
  `is_server_event` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `events` int(11) DEFAULT NULL,
  `total_amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_statistic_id`),
  UNIQUE KEY `unique` (`user_id`,`year`,`event_type_id`,`location_id`,`service_at_area_id`,`is_server_event`),
  KEY `year` (`year`),
  KEY `event_type` (`event_type_id`),
  KEY `location` (`location_id`),
  KEY `service_at_area` (`service_at_area_id`),
  KEY `is_server_event` (`is_server_event`),
  KEY `events` (`events`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_type`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `user_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vat_group`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vat_group` (
  `vat_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `percentage` float NOT NULL DEFAULT '0',
  `account_number` varchar(10) DEFAULT NULL,
  `is_active` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`vat_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-14 15:55:42

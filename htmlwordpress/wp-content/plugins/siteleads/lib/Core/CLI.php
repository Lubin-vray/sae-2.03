<?php

namespace SiteLeads\Core;

use SiteLeads\Features\Widgets\FCWidgetsManager;

class CLI {

	use Singleton;


	public function __construct() {
		if ( self::isWPCLI() ) {
			$this->registerCommands();
		}
	}

	public function registerCommands() {
		if ( ! class_exists( 'WP_CLI' ) ) {
			return;
		}

		\WP_CLI::add_command(
			'siteleads setup_default_widget',
			array( $this, 'setup_default_widget' ),
			array(
				'shortdesc' => 'Setup SiteLeads plugin first widget with default configuration.',
				'longdesc'  => 'This command creates a default SiteLeads widget with phone, WhatsApp, and email options enabled. It is useful for quickly setting up the plugin with a basic configuration.',
			)
		);
	}

	public function setup_default_widget( $args, $assoc_args ) {

		FCWidgetsManager::createDefaultWidgetWithPhoneWhatsappAndEmail(
			array(
				'isEnabled'    => true,
				'start_source' => 'cli_command',
			)
		);

		\WP_CLI::success( 'SiteLeads widget setup completed successfully.' );
	}

	public static function isWPCLI() {
		return defined( 'WP_CLI' ) && WP_CLI;
	}
}

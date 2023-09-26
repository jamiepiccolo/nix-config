{ config, lib, pkgs, modulesPath, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    preferences = {
      "nglayout.initialpaint.delay" = 0;
      "nglayout.initialpaint.delay_in_oopif" = 0;
      "content.notify.interval" = 100000;

      # EXPERIMENTAL
      "layout.css.grid-template-masonry-value.enabled" = true;
      "dom.enable_web_task_scheduling" = true;
      "layout.css.has-selector.enabled" = true;
      "dom.security.sanitizer.enabled" = true;

      # GFX
      "gfx.canvas.accelerated.cache-items" = 4096;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 20;

      # BROWSER CACHE
      "browser.cache.disk.enable" = false;

      # MEDIA CACHE
      "media.memory_cache_max_size" = 65536;
      "media.cache_readahead_limit" = 7200;
      "media.cache_resume_threshold" = 3600;

      # IMAGE CACHE
      "image.mem.decode_bytes_at_a_time" = 32768;

      # NETWORK
      "network.buffer.cache.size" = 262144;
      "network.buffer.cache.count" = 128;
      "network.http.max-connections" = 1800;
      "network.http.max-persistent-connections-per-server" = 10;
      "network.http.max-urgent-start-excessive-connections-per-host" = 5;
      "network.http.pacing.requests.enabled" = false;
      "network.dnsCacheEntries" = 1000;
      "network.dnsCacheExpiration" = 86400;
      "network.dns.max_high_priority_threads" = 8;
      "network.ssl_tokens_cache_capacity" = 10240;

      # SPECULATIVE CONNECTIONS
      "network.http.speculative-parallel-limit" = 0;
      "network.dns.disablePrefetch" = true;
      "browser.urlbar.speculativeConnect.enabled" = false;
      "browser.places.speculativeConnect.enabled" = false;
      "network.prefetch-next" = false;
      "network.predictor.enabled" = false;
      "network.predictor.enable-prefetch" = false;

      # TRACKING PROTECTION
      "browser.contentblocking.category" = "strict";
      "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok =.com";
      "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg =.com";
      "browser.uitour.enabled" = false;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.globalprivacycontrol.functionality.enabled" = true;

      # OCSP & CERTS / HPKP
      "security.OCSP.enabled" = 0;
      "security.remote_settings.crlite_filters.enabled" = true;
      "security.pki.crlite_mode" = 2;
      "security.cert_pinning.enforcement_level" = 2;

      # SSL / TLS
      "security.ssl.treat_unsafe_negotiation_as_broken" = true;
      "browser.xul.error_pages.expert_bad_cert" = true;
      "security.tls.enable_0rtt_data" = false;

      # DISK AVOIDANCE
      "browser.privatebrowsing.forceMediaMemoryCache" = true;
      "browser.sessionstore.interval" = 60000;

      # SHUTDOWN & SANITIZING
      "privacy.history.custom" = true;

      # SEARCH / URL BAR
      "browser.search.separatePrivateDefault.ui.enabled" = true;
      "browser.urlbar.update2.engineAliasRefresh" = true;
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.formfill.enable" = false;
      "security.insecure_connection_text.enabled" = true;
      "security.insecure_connection_text.pbmode.enabled" = true;
      "network.IDN_show_punycode" = true;

      # HTTPS-FIRST POLICY
      "dom.security.https_first" = true;

      # PASSWORDS AND AUTOFILL
      "signon.rememberSignons" = false;
      "editor.truncate_user_pastes" = false;

      # ADDRESS + CREDIT CARD MANAGER
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;

      # MIXED CONTENT + CROSS-SITE
      "network.auth.subresource-http-auth-allow" = 1;
      "security.mixed_content.block_display_content" = true;
      "pdfjs.enableScripting" = false;
      "extensions.postDownloadThirdPartyPrompt" = false;
      "permissions.delegation.enabled" = false;

      # HEADERS / REFERERS
      "network.http.referer.XOriginTrimmingPolicy" = 2;

      # CONTAINERS
      "privacy.userContext.ui.enabled" = true;

      # WEBRTC
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      "media.peerconnection.ice.default_address_only" = true;

      # SAFE BROWSING
      "browser.safebrowsing.downloads.remote.enabled" = false;

      # MOZILLA
      "accessibility.force_disabled" = 1;
      "identity.fxaccounts.enabled" = false;
      "browser.tabs.firefox-view" = false;
      "permissions.default.desktop-notification" = 2;
      "permissions.default.geo" = 2;
      "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
      "permissions.manager.defaultsUrl" = "";
      "webchannel.allowObject.urlWhitelist" = "";

      # TELEMETRY
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.server" = "data=:,";
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.coverage.opt-out" = true;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "app.shield.optoutstudies.enabled" = false;
      "browser.discovery.enabled" = false;
      "breakpad.reportURL" = "";
      "browser.tabs.crashReporting.sendReport" = false;
      "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
      "captivedetect.canonicalURL" = "";
      "network.captive-portal-service.enabled" = false;
      "network.connectivity-service.enabled" = false;
      "app.normandy.enabled" = false;
      "app.normandy.api_url" = "";
      "browser.ping-centre.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;

      "layout.css.prefers-color-scheme.content-override" = 2;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "app.update.suppressPrompts" = true;
      "browser.compactmode.show" = true;
      "browser.privatebrowsing.vpnpromourl" = "";
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      "browser.preferences.moreFromMozilla" = false;
      "browser.tabs.tabmanager.enabled" = false;
      "browser.aboutConfig.showWarning" = false;
      "browser.aboutwelcome.enabled" = false;
      "browser.display.focus_ring_on_anything" = true;
      "browser.display.focus_ring_style" = 0;
      "browser.display.focus_ring_width" = 0;
      "cookiebanners.service.mode" = 2;
      "cookiebanners.service.mode.privateBrowsing" = 2;
      "browser.translations.enable" = true;

      # FULLSCREEN
      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.warning.delay" = -1;
      "full;-screen-api.warning.timeout" = 0;

      # URL BAR
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.suggest.calculator" = true;
      "browser.urlbar.unitConversion.enabled" = true;

      # NEW TAB PAGE
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;


      "extensions.pocket.enabled" = false;

      # DOWNLOADS
      "browser.download.useDownloadDir" = false;
      "browser.download.always_ask_before_handling_new_types" = true;
      "browser.download.alwaysOpenPanel" = false;
      "browser.download.manager.addToRecentDocs" = false;

      # PDF
      "browser.download.open_pdf_attachments_inline" = true;
      "pdfjs.sidebarViewOnLoad" = 2;

      # TAB BEHAVIOR
      "browser.tabs.loadBookmarksInTabs" = true;
      "browser.bookmarks.openInTabClosesMenu" = false;
      "browser.menu.showViewImageInfo" = true;
      "findbar.highlightAll" = true;
    };
  };
}
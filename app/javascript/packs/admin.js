require("jquery");
require("admin-lte");
require("trix");
require("@nathanvda/cocoon");
require("@rails/actiontext");

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "../trix-editor-overrides";
import "jquery";
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
ActiveStorage.start()
import { Application } from "@hotwired/stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Start Stimulus application
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Automatically load all controllers from controllers/ folder
eagerLoadControllersFrom("controllers", application)

export { application }

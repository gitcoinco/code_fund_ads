// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import StimulusReflex from 'stimulus_reflex'
import consumer from '../channels/consumer'

const application = Application.start()
const context = require.context('controllers', true, /_controller\.js$/)
const context_components = require.context(
  '../../components',
  true,
  /_controller.js$/
)
application.load(
  definitionsFromContext(context).concat(
    definitionsFromContext(context_components)
  )
)
StimulusReflex.initialize(application, { consumer })

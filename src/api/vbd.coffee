# FIXME: too low level, should be removed.

{coroutine: $coroutine} = require 'bluebird'

#=====================================================================

delete_ = $coroutine ({vbd}) ->
  xapi = @getXAPI vbd

  # TODO: check if VBD is attached before
  yield xapi.call 'VBD.destroy', vbd._xapiRef

  return true

delete_.params = {
  id: { type: 'string' }
}

delete_.resolve = {
  vbd: ['id', 'VBD', 'administrate'],
}

exports.delete = delete_

#---------------------------------------------------------------------

disconnect = $coroutine ({vbd}) ->
  xapi = @getXAPI vbd
  yield xapi.disconnectVbd(vbd._xapiRef)
  return

disconnect.params = {
  id: { type: 'string' }
}

disconnect.resolve = {
  vbd: ['id', 'VBD', 'administrate'],
}

exports.disconnect = disconnect

#---------------------------------------------------------------------

connect = $coroutine ({vbd}) ->
  xapi = @getXAPI vbd
  yield xapi.connectVbd(vbd._xapiRef)
  return

connect.params = {
  id: { type: 'string' }
}

connect.resolve = {
  vbd: ['id', 'VBD', 'administrate'],
}

exports.connect = connect

#---------------------------------------------------------------------

set = $coroutine (params) ->
  {vbd} = params
  xapi = @getXAPI vbd

  { _xapiRef: ref } = vbd

  # VBD position
  if 'position' of params
    yield xapi.call 'VBD.set_userdevice', ref, String(params.position)

set.params = {
  # Identifier of the VBD to update.
  id: { type: 'string' }

  position: { type: ['string', 'number'], optional: true }

}

set.resolve = {
  vbd: ['id', 'VBD', 'administrate'],
}

exports.set = set

#=====================================================================

Object.defineProperty(exports, '__esModule', {
  value: true
})

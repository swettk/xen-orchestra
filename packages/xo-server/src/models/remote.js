import isEmpty from 'lodash/isEmpty'
import Collection from '../collection/redis'
import Model from '../model'
import { forEach } from '../utils'

import { parseProp } from './utils'

// ===================================================================

export default class Remote extends Model {}

export class Remotes extends Collection {
  get Model() {
    return Remote
  }

  async update(remote) {
    // Serializes.
    // console.log('remote', '18', remote.speed)
    remote.speed = isEmpty(remote.speed)
      ? undefined
      : JSON.stringify(remote.speed)

    return /* await */ remote
  }

  async get(properties) {
    const remotes = await super.get(properties)
    forEach(remotes, remote => {
      remote.enabled = remote.enabled === 'true'
      console.log('remote', '30', remote.speed)
      remote.speed = parseProp('remote', remote, 'speed', '')
    })
    return remotes
  }
}

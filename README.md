# Internal Wallet API Demo

### Endpoints

<details>
<summary><code>POST</code> <code><b>/login</b></code> <code>Simple authentication using email only</code></summary>

##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | email      |  required | string  | return cookie header to be use in the subsequent requests  |


##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"id":2,"email":"mbc@yahoo.com","created_at":"2023-09-11T06:56:07.403Z","updated_at":"2023-09-11T06:56:07.403Z"}`                                |
> | `400`         | `application/json`                | `{"errors":{...}}`                            |

##### Example cURL

> ```javascript
>  curl -v -X POST -d email=mbc@yahoo.com http://127.0.0.1:3000/login
> ```

</details>

<details>
<summary><code>GET</code> <code><b>/wallet</b></code> <code>Get current user wallet information</code></summary>

##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"id":2,"user_id":2,"created_at":"2023-09-11T06:56:07.476Z","updated_at":"2023-09-11T06:56:07.476Z","balance":970.0,"credits":[{"id":1,"amount":1000.0,"source_wallet_id":null,"target_wallet_id":2,"created_at":"2023-09-11T07:15:51.933Z","updated_at":"2023-09-11T07:15:51.933Z"},{"id":2,"amount":1000.0,"source_wallet_id":null,"target_wallet_id":2,"created_at":"2023-09-11T07:16:21.980Z","updated_at":"2023-09-11T07:16:21.980Z"}],"debits":[{"id":3,"amount":1000.0,"source_wallet_id":2,"target_wallet_id":null,"created_at":"2023-09-11T07:20:46.033Z","updated_at":"2023-09-11T07:20:46.033Z"},{"id":4,"amount":10.0,"source_wallet_id":2,"target_wallet_id":null,"created_at":"2023-09-11T07:21:47.299Z","updated_at":"2023-09-11T07:21:47.299Z"},{"id":5,"amount":10.0,"source_wallet_id":2,"target_wallet_id":null,"created_at":"2023-09-11T07:22:29.456Z","updated_at":"2023-09-11T07:22:29.456Z"},{"id":6,"amount":10.0,"source_wallet_id":2,"target_wallet_id":1,"created_at":"2023-09-11T07:30:15.360Z","updated_at":"2023-09-11T07:30:15.360Z"}]}`                                |

##### Example cURL

> ```javascript
>  curl -H 'Cookie: ...' http://127.0.0.1:3000/wallet
> ```

</details>

<details>
<summary><code>POST</code> <code><b>/deposit</b></code> <code>Depositing money to current user wallet</code></summary>

##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | amount      |  required | decimal  |  Can't be negative |


##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"id":7,"amount":1000.0,"source_wallet_id":null,"target_wallet_id":2,"created_at":"2023-09-11T07:59:18.146Z","updated_at":"2023-09-11T07:59:18.146Z","target_wallet":{"id":2,"user_id":2,"created_at":"2023-09-11T06:56:07.476Z","updated_at":"2023-09-11T06:56:07.476Z","balance":1970.0}}`                                |
> | `400`         | `application/json`                | `{"errors":{...}}`                            |

##### Example cURL

> ```javascript
>  curl -X POST -H 'Cookie: ...' -d amount=1000 http://127.0.0.1:3000/deposit
> ```

</details>

<details>
<summary><code>POST</code> <code><b>/withdraw</b></code> <code>Withdrawing money from current user wallet</code></summary>

##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | amount      |  required | decimal  |  Can't be negative or more than wallet balance |


##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"id":8,"amount":10.0,"source_wallet_id":2,"target_wallet_id":null,"created_at":"2023-09-11T08:01:00.874Z","updated_at":"2023-09-11T08:01:00.874Z","source_wallet":{"id":2,"user_id":2,"created_at":"2023-09-11T06:56:07.476Z","updated_at":"2023-09-11T06:56:07.476Z","balance":1960.0}}`                                |
> | `400`         | `application/json`                | `{"errors":{...}}`                            |

##### Example cURL

> ```javascript
>  curl -X POST -H 'Cookie: ...' -d amount=1000 http://127.0.0.1:3000/withdraw
> ```

</details>

<details>
<summary><code>POST</code> <code><b>/withdraw</b></code> <code>Transfering money to other wallet</code></summary>

##### Parameters

> | name      |  type     | data type               | description                                                           |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | amount      |  required | decimal  |  Can't be negative or more than wallet balance |
> | target_wallet_id      |  required | integer  |  N/A |


##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `application/json`        | `{"id":9,"amount":10.0,"source_wallet_id":2,"target_wallet_id":1,"created_at":"2023-09-11T08:05:07.827Z","updated_at":"2023-09-11T08:05:07.827Z","source_wallet":{"id":2,"user_id":2,"created_at":"2023-09-11T06:56:07.476Z","updated_at":"2023-09-11T06:56:07.476Z","balance":1950.0}}`                                |
> | `400`         | `application/json`                | `{"errors":{...}}`                            |

##### Example cURL

> ```javascript
>  curl -X POST -H 'Cookie: ...' -d 'amount=10&target_wallet_id=1' http://127.0.0.1:3000/transfer
> ```

</details>

### Note

I didn't get the chance to test `LatestStockPrice` class yet.
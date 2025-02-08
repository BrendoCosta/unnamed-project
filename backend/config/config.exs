import Config

config :izumi,
  mongodb_url: "",
  mongodb_database: ""

config :joken, default_signer: [
  signer_alg: "HS256",
  key_octet: ""
]

use Mix.Config

config :pke, keys: Pke.Keys.FromFile
config :pke, encryption_algorithm: Pke.Encrypt.Timer


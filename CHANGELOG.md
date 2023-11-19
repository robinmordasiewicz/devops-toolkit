# CHANGELOG

## [1.1.0](https://github.com/robinmordasiewicz/devops-toolkit/compare/v1.0.0...v1.1.0) (2023-11-19)


### Features

* **workflows:** add init job to check OPENAI_API_KEY existence in openai-pr-description.yml ([a037f87](https://github.com/robinmordasiewicz/devops-toolkit/commit/a037f8798122bff063b65d7e5551e275d0148e79))


### Bug Fixes

* **release-please.yml:** remove token and path parameters from release-please action ([d08cf0d](https://github.com/robinmordasiewicz/devops-toolkit/commit/d08cf0d2ec00c46d9ebff947c81d6561a6d9eaea))

## 1.0.0 (2023-11-19)


### Bug Fixes

* **terraform:** remove unnecessary line in main.tf for cleaner code ([2b6cb5f](https://github.com/robinmordasiewicz/devops-toolkit/commit/2b6cb5f0b38fc64e1ec627721bd0ab1187a7aaeb))

## [2.14.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.13.0...v2.14.0) (2023-11-18)


### Features

* **auto-pull-request.yml:** add concurrency control to prevent redundant workflow runs ([ee89e43](https://github.com/robinmordasiewicz/fortinet-devops/commit/ee89e438b9c31602812dc293d83434c32a1926f6))
* **workflows:** add concurrency control to release-please workflow ([a29ca6d](https://github.com/robinmordasiewicz/fortinet-devops/commit/a29ca6df05b72bf7bbaff2a2afa5ceff6a4f6337))

## [2.13.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.12.1...v2.13.0) (2023-11-18)


### Features

* adding screenshot workflows ([090506b](https://github.com/robinmordasiewicz/fortinet-devops/commit/090506bf7963fafeb3b3c5cb58da961ce25c9d04))
* adding screenshot workflows ([acfd639](https://github.com/robinmordasiewicz/fortinet-devops/commit/acfd6391635f84eeaddfd9be3c42106b440565a1))
* adding screenshot workflows ([f425e7c](https://github.com/robinmordasiewicz/fortinet-devops/commit/f425e7cf5d6cd164f45efb054a607453e4971e22))
* adding screenshot workflows ([1a94b2d](https://github.com/robinmordasiewicz/fortinet-devops/commit/1a94b2da98f940f016cb7ca181c9dd14313736d2))
* adding screenshot workflows ([e2d5102](https://github.com/robinmordasiewicz/fortinet-devops/commit/e2d5102582fea70ff652abb7affac9f9b3ea6a15))
* adding screenshot workflows ([e44fe48](https://github.com/robinmordasiewicz/fortinet-devops/commit/e44fe4860dd088f1850b714d7bfbb810965a35ad))

## [2.12.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.12.0...v2.12.1) (2023-11-17)


### Bug Fixes

* **screenshots.yml:** add additional flags to the chrome command to prevent sandboxing and setuid sandboxing ([6b60224](https://github.com/robinmordasiewicz/fortinet-devops/commit/6b6022440bf0f48400cbac3fa1a4fb3d33dbb1a7))
* **screenshots.yml:** fix typo in disable-gpu flag to properly disable GPU acceleration ([0fa24ff](https://github.com/robinmordasiewicz/fortinet-devops/commit/0fa24fffadf46d5f57272f337b341b03bc6e8953))
* **screenshots.yml:** update runs-on value from 'ubuntu-22.04' to 'ubuntu-latest' for compatibility ([a00db82](https://github.com/robinmordasiewicz/fortinet-devops/commit/a00db828233df38dd1fa2c53f0289300f7038cc0))
* **screenshots.yml:** update setup-xvfb action version to b6b4fcfb9f5a895edadc3bc76318fae0ac17c8b3 ([00cccdb](https://github.com/robinmordasiewicz/fortinet-devops/commit/00cccdb2a3442660987bb542590f4d9004178665))

## [2.12.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.11.3...v2.12.0) (2023-11-17)


### Features

* add auto-pull-request workflow and remove pull-request-label workflow ([a0f18fc](https://github.com/robinmordasiewicz/fortinet-devops/commit/a0f18fc3a53fb8e499ae7f9602ba804bc15af9db))

## [2.11.3](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.11.2...v2.11.3) (2023-11-17)


### Bug Fixes

* **mkdoc.yml:** move terraform deployment ([8df4679](https://github.com/robinmordasiewicz/fortinet-devops/commit/8df4679a1408c36954e81bbe363f6adaf02316ce))

## [2.11.2](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.11.1...v2.11.2) (2023-11-17)


### Bug Fixes

* **mkdoc.yml:** update nav menu label ([897859e](https://github.com/robinmordasiewicz/fortinet-devops/commit/897859ec21d520d04dcca040418180e48b850ad7))

## [2.11.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.11.0...v2.11.1) (2023-11-17)


### Bug Fixes

* **.mega-linter.yml:** conditionally run linter ([0f55b20](https://github.com/robinmordasiewicz/fortinet-devops/commit/0f55b20435192197341b0d5de6b2a288d78a4b9c))
* **.mega-linter.yml:** conditionally run linter ([7857e8b](https://github.com/robinmordasiewicz/fortinet-devops/commit/7857e8b7194e1dc1164e0261e106b8c58c29ac5f))
* **linter.yml:** do not run on release-please ([6b9df7f](https://github.com/robinmordasiewicz/fortinet-devops/commit/6b9df7fac0a7aa20108cc889ae75bd6cc144893a))
* **linter.yml:** do not run on release-please ([b2946e7](https://github.com/robinmordasiewicz/fortinet-devops/commit/b2946e7571a75137cf61940a2a71e2b58bdc6267))
* **linter.yml:** do not run on release-please ([26d91c5](https://github.com/robinmordasiewicz/fortinet-devops/commit/26d91c5895ddb73c26fb298573259bf2d0497499))
* **linter.yml:** do not run on release-please ([b35b6b3](https://github.com/robinmordasiewicz/fortinet-devops/commit/b35b6b3ef8c1e1e0203a7d245955729a0fef2e69))
* **openai-pr-description.yml:** do not run on release-please ([102a71d](https://github.com/robinmordasiewicz/fortinet-devops/commit/102a71d1602cebfccc6a44d32885db1c2cf48ccd))

## [2.11.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.10.1...v2.11.0) (2023-11-17)


### Features

* **workflows:** add conditional execution to linter, openai-pr-description, and pull-request workflows ([fb065bc](https://github.com/robinmordasiewicz/fortinet-devops/commit/fb065bc147197b0b896cfc9eb5e5ab7b2340eec1))

## [2.10.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.10.0...v2.10.1) (2023-11-17)


### Bug Fixes

* **.mega-linter.yml:** set terrascan to non recursive ([cffa03f](https://github.com/robinmordasiewicz/fortinet-devops/commit/cffa03f5069802af9dbfd17189bfd1c00737f60c))

## [2.10.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.9.1...v2.10.0) (2023-11-17)


### Features

* adding extra javascript ([884c60f](https://github.com/robinmordasiewicz/fortinet-devops/commit/884c60fe51832403ff3b54a6a7888c2d83791811))
* adding product svg icons ([05aa047](https://github.com/robinmordasiewicz/fortinet-devops/commit/05aa04714f699856411d0a6ad71936887730ae0c))

## [2.9.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.9.0...v2.9.1) (2023-11-17)


### Bug Fixes

* **linter.yml:** linter run on PR to main branch ([12d89a5](https://github.com/robinmordasiewicz/fortinet-devops/commit/12d89a5efc3bb1764a1753b3a2a8ad5196c1f777))

## [2.9.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.8.2...v2.9.0) (2023-11-17)


### Features

* add dark mode for svg ([c9f7004](https://github.com/robinmordasiewicz/fortinet-devops/commit/c9f70040c08bbb6178b89991211b6b579b588341))

## [2.8.2](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.8.1...v2.8.2) (2023-11-17)


### Bug Fixes

* **changelog.yml:** remove duplicate changelog action ([aa54c8c](https://github.com/robinmordasiewicz/fortinet-devops/commit/aa54c8cf28450e7415e651c30a5d005bada87be0))

## [2.8.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.8.0...v2.8.1) (2023-11-17)


### Bug Fixes

* throttle back openai gpt-3.5-turbo ([2a8ed9a](https://github.com/robinmordasiewicz/fortinet-devops/commit/2a8ed9a615fbec8332a3a03814156a7256d88658))

## [2.8.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.7.0...v2.8.0) (2023-11-16)


### Features

* add linter workflow to GitHub Actions ([ccf3a86](https://github.com/robinmordasiewicz/fortinet-devops/commit/ccf3a867012a8a08d592975f32eefa5fa5914012))


### Bug Fixes

* clean up linting ([becc623](https://github.com/robinmordasiewicz/fortinet-devops/commit/becc623df26a20a210a55f6a2c2ee3c6447211c7))
* shorten workflow timeout to four minutes ([3545271](https://github.com/robinmordasiewicz/fortinet-devops/commit/3545271c66a6853d8e61428202db7e4edd789436))

## [2.7.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.6.0...v2.7.0) (2023-11-16)

### Features

* **.github/workflows:** add opencommit.yml for automated commit message generation ([2dc2f8d](https://github.com/robinmordasiewicz/fortinet-devops/commit/2dc2f8d4699933d9995cc1f32a08dc12f84f17f4))

## [2.6.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.5.0...v2.6.0) (2023-11-16)

### Features

* **terraform-docs.yml:** exclude data, var, output from terraform docs ([5416838](https://github.com/robinmordasiewicz/fortinet-devops/commit/541683885d4d633ab85f8fc6389e1b34684628fb))

## [2.5.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.4.0...v2.5.0) (2023-11-16)

### Features

* **terraform-docs.yml:** integrate tfmermaid-action to generate mermaid diagrams ([0bdbe2e](https://github.com/robinmordasiewicz/fortinet-devops/commit/0bdbe2e2f0ed933444b767d02293b8da35987c33))

## [2.4.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.3.1...v2.4.0) (2023-11-16)

### Features

* **openai-pr-description.yml:** add openai_model and max_tokens parameters to the workflow ([fe9b52e](https://github.com/robinmordasiewicz/fortinet-devops/commit/fe9b52e5f4a402dc07ad1a9dc550371d95b5041b))

### Bug Fixes

* resize icons ([cf901ad](https://github.com/robinmordasiewicz/fortinet-devops/commit/cf901ad05bbc2e591ceb65b08ae8c4a5ccf3453b))

## [2.3.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.3.0...v2.3.1) (2023-11-16)

### Bug Fixes

* **fortidevsec-sast.yml:** replace --risk_value with --risk_rating in docker run command ([5f45488](https://github.com/robinmordasiewicz/fortinet-devops/commit/5f454880cba5cbe80bd4121caef77d1d3d1a3a60))

## [2.3.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.2.4...v2.3.0) (2023-11-16)

### Features

* **fortidevsec-sast.yml:** add risk_value parameter to docker run command ([55b0bd6](https://github.com/robinmordasiewicz/fortinet-devops/commit/55b0bd6d345c7d6f2c87207deb4aef29b8fd19c0))

## [2.2.4](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.2.3...v2.2.4) (2023-11-15)

### Bug Fixes

* remove bad file ([d847a5e](https://github.com/robinmordasiewicz/fortinet-devops/commit/d847a5e2e8db0b66a2ee04dc467ea08649277112))

## [2.2.3](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.2.2...v2.2.3) (2023-11-15)

### Bug Fixes

* improving navigation flow ([eeb829a](https://github.com/robinmordasiewicz/fortinet-devops/commit/eeb829a70862cf26c7d677af6d58366997577389))

## [2.2.2](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.2.1...v2.2.2) (2023-11-15)

### Bug Fixes

* renamed profile to github-profile ([f864a6c](https://github.com/robinmordasiewicz/fortinet-devops/commit/f864a6c79ee7252b71aaa9a5341b6636eef2c669))
* updated giscuss config ([311b2a2](https://github.com/robinmordasiewicz/fortinet-devops/commit/311b2a25bfef9430716353f376c6fb91f64f4cee))

## [2.2.1](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.2.0...v2.2.1) (2023-11-15)

### Bug Fixes

* updating basic document structure ([ece3a33](https://github.com/robinmordasiewicz/fortinet-devops/commit/ece3a33947a505b81fbe6569db80e4f9e151be36))

## [2.2.0](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.1.8...v2.2.0) (2023-11-15)

### Features

* feat:  ([85294a0](https://github.com/robinmordasiewicz/fortinet-devops/commit/85294a0222b1321d2c55fb2fa6a241b87d2eeae5))

## [v2.1.8](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.8) - 2023-11-12 22:30:05

## [2.1.8](https://github.com/robinmordasiewicz/fortinet-devops/compare/v2.1.6...v2.1.8) (2023-11-12)

### Bug Fixes

* release 2.1.7 ([4026cb4](https://github.com/robinmordasiewicz/fortinet-devops/commit/4026cb449340028410929340b21897407fc8b041))
* release 2.1.8 ([5b667e7](https://github.com/robinmordasiewicz/fortinet-devops/commit/5b667e75ad812ccd8483696f417120f8448f0e35))

### Bug Fixes

* general:
  * release 2.1.8 ([5b667e7](https://github.com/robinmordasiewicz/fortinet-devops/commit/5b667e75ad812ccd8483696f417120f8448f0e35)) ([#79](https://github.com/robinmordasiewicz/fortinet-devops/pull/79))
  * release 2.1.7 ([4026cb4](https://github.com/robinmordasiewicz/fortinet-devops/commit/4026cb449340028410929340b21897407fc8b041)) ([#79](https://github.com/robinmordasiewicz/fortinet-devops/pull/79))

## [v2.1.6](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.6) - 2023-11-12 20:11:21

## [v2.1.5](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.5) - 2023-11-12 07:20:56

## [v2.1.4](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.4) - 2023-11-12 04:47:58

## [v2.1.3](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.3) - 2023-11-09 19:52:57

## [v2.1.2](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.2) - 2023-11-09 19:03:14

## [v2.1.1](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.1) - 2023-11-09 18:52:04

## [v2.1.0](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.1.0) - 2023-11-09 18:22:22

## [v2.0.0](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v2.0.0) - 2023-11-09 17:57:01

## [v1.1.0](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v1.1.0) - 2023-11-09 17:23:06

## [v1.0.0](https://github.com/robinmordasiewicz/fortinet-devops/releases/tag/v1.0.0) - 2023-11-09 17:11:05

\* *This CHANGELOG was automatically generated by [auto-generate-changelog](https://github.com/BobAnkh/auto-generate-changelog)*

DO NOT DELETE MASTER BRANCH
===========================

Requirements
------------

- Slack
- Heroku

Setup
-----

### 1. Create Slack incoming webhook integration

Copy webhook URL.

In order to get desktop notification from incoming webhook post, you need to listen all activities in a channel.

It is recommended to create new channel or private group for this integration (of course you need to join the channel).

![2015-06-11 5 43 45](https://cloud.githubusercontent.com/assets/10515/8103212/a3409d58-1061-11e5-96e1-780a7e2ca2dc.png)

### 2. Deploy webhook receiver web app to Heroku

```
$ git clone [this repo]

$ heroku apps:create

$ git push heroku master

$ heroku config:set SLACK_INCOMING_WEBHOOK_URL=........
```

Copy deployed Heroku app URL.

### 3. Add new webhook of GitHub repository

"Delete" webhook event must be selected. All other events will be ignored.

![2015-06-11 5 34 15](https://cloud.githubusercontent.com/assets/10515/8103211/a0b451ec-1061-11e5-80f8-4d5a5940bef8.png)

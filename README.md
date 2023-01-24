# voice Chat GPT

An app that decodes user's questions through their voices and uses Chat-GPT's api to provide a coressponding answer and is also inturn read out by a bot's voice using text to speech.

Table of contents
=================
<!--ts-->
   * [Project Structure](#project-structure)
   * [Tools Used](#tools-used)
   * [App Demo](#app-demo)
   
<!--te-->

Project Structure
=================
Since this app is a one screen mobile application, I made use of a simple folder structure that allows for proper separation of concerns. 

Below is a table showing what each folder does.

| Folders | Description |
| ------- | ------- |
| presentaton | All `widget` and `bloc/cubit` classes go in here |
| models | All `model` classes go in here |
| data | Api and repository classes go in here |


Tools Used
==========

| Tools | Usage |
| ------- | ------- |
| Bloc | State Management |
| SpeechToText | Decoding user input |
| TextToSpeech | Outputing ai response |
| OpenAi Completion Api Endpoint | Backend Service |

To make use of the api endpoint you need an api key, which you can find [here](https://beta.openai.com)

App Demo
========

The link to this projects apk file will be uploaded here.




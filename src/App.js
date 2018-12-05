import React, { Component } from 'react';
import { EventEmitter } from 'events';
import { Dispatcher } from 'flux';
import logo from './logo.svg';
import './App.css';

import storyContent from './story';
// console.log(storyContent)
let Story = require('inkjs').Story;
const ink = new Story(storyContent);


const GameActions = dispatcher =>
({
    makeChoice(choice) {
        dispatcher.handleAction({type: 'CHOICE', index: choice})
    }
})

class GameDispatcher extends Dispatcher {
    handleAction(action) {
        // console.log('dispatching action:', action)
        this.dispatch({
            source: 'UI',
            action
        })
    }
}

class GameStore extends EventEmitter {
    constructor(story, dispatcher) {
        super()
        this._story = story
        this._paras = []
        this._location = ''
        this._score = 0
        this._story.ObserveVariable('location', this.watchHandler.bind(this))
        this._story.ObserveVariable('score', this.watchHandler.bind(this))
        this.dispatcherIndex = dispatcher.register( this.dispatch.bind(this) )
    }

    watchHandler(name, value) {
        // console.log(`watch: ${name} = ${value.toString()}`)
        this['_' + name] = value.toString()
    }

    get story() {
        this._paras = []
        while ( this._story.canContinue ){
            this._paras.push({'type': 'para', 'value': this._story.Continue()})
            this._paras.push({'type': 'tags', 'value': this._story.currentTags})
        }
        return this._paras
    }
    get choices() {
        return this._story.currentChoices
    }

    get location() {
        return this._location
    }
    get max_score() {
        return this._story.variablesState['max_possible_score']
    }

    get score() {
        return this._score
    }

    dispatch(payload) {
        // console.log('payload', payload)
        const { type, index } = payload.action
        switch (type) {
            case 'CHOICE':
                this._story.ChooseChoiceIndex(index)
                this.emit("CHOICEMADE", payload.action)
                return true
            default:
                return false
        }

    }
}

const gameDispatcher = new GameDispatcher()
const gameActions = new GameActions(gameDispatcher)
const gameStore = new GameStore(ink, gameDispatcher)

function getGameState() {
    return {
        story: gameStore.story,
        choices: gameStore.choices,
        location: gameStore.location,
        score: gameStore.score,
        max_score : gameStore.max_score
    }
}
class App extends Component {
    constructor(props) {
        super(props)
        this.state = getGameState()
    }

    componentDidMount() {
        gameStore.addListener('CHOICEMADE', () => this.handleChoiceMade(), this)
    }
    render() {
        const {story, choices, location, score, max_score} = this.state
        return (
            <div className="App">
            <header className="App-header">
            <img src={logo} className="App-logo" alt="logo" />
            <h1>{ location }</h1>
            <strong>Score: {score}/{max_score}</strong>
            {story.map((obj, i) => {
                    switch(obj.type) {
                        case "para": return <p key={i}>{ obj.value }</p>
                        case "tags": return obj.value.map((tag, i) =><strong key={i}>{tag}</strong>)
                        default:
                    }
                    return ''
                }
            )}

            {choices.map((choice, i) =>
                <button
                className="choice"
                key={i}
                onClick={() => this.handleChoice(choice)}
                >
                { choice.text }
                </button>

            )}

            </header>
            </div>
        );
    }

    handleChoiceMade() {
        this.setState(getGameState())
    }
    handleChoice(choice) {
        // console.log(choice)
        gameActions.makeChoice(choice.index)
    }
}

export default App;

import React, { Component } from 'react';
import { EventEmitter } from 'events';
import { Dispatcher } from 'flux';
import logo from './logo.svg';
import './App.css';

import storyContent from './story';
console.log(storyContent)
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
        this.dispatcherIndex = dispatcher.register( this.dispatch.bind(this) )
    }
    get story() {
        let paras = []
        while ( this._story.canContinue ){
            paras.push(this._story.Continue())
        }
        return paras
    }
    get choices() {
        return this._story.currentChoices
    }

    dispatch(payload) {
        // console.log('payload', payload)
        const { type, index } = payload.action
        switch (type) {
            case 'CHOICE':
                this._story.ChooseChoiceIndex(index)
                this.emit("CHOICEMADE", payload.action)
                return true
        }

    }
}

const gameDispatcher = new GameDispatcher()
const gameActions = new GameActions(gameDispatcher)
const gameStore = new GameStore(ink, gameDispatcher)

function getGameState() {
    return {
        story: gameStore.story,
        choices: gameStore.choices
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
        const {story} = this.state
        const {choices} = this.state
        return (
            <div className="App">
            <header className="App-header">
            <img src={logo} className="App-logo" alt="logo" />
            { story.map((text, i) =>
                <p key={i}>{ text }</p>
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
        //console.log(choice)
        gameActions.makeChoice(choice.index)
    }
}

export default App;

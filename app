import React, { Component } from "react";

class App extends Component {
  state = {
    newTitle: "",
    newDescription: "",
    newTopic: "",
    AddedAgenda: [
      {
        title: "Angular",
        description: "Some description about Angular",
        topics: ["Introduction", "Typescript", "Why Angular?", "Understanding Versions", "Fundamentals"],
      },
      {
        title: "Vue",
        description: "Some description about Vue",
        topics: ["Introduction", "Javascript", "Why Vue?", "Vue Bindings", "Component Interaction"],
      },
    ],
    topicsArr: [],
    showAgendaBlock: false,
  };

  changeFun = (e) => {
    const value = e.target.value;
    const name = e.target.name;
    this.setState({ [name]: value });
  };

  topicFun = () => {
    this.setState((prevState) => ({
      topicsArr: [...prevState.topicsArr, prevState.newTopic],
      newTopic: "",
    }));
  };

  agendaFun = () => {
    const agenda = {
      title: this.state.newTitle,
      description: this.state.newDescription,
      topics: this.state.topicsArr,
    };
    this.setState((prevState) => ({
      AddedAgenda: [...prevState.AddedAgenda, agenda],
      newTitle: "",
      newDescription: "",
      newTopic: "",
      topicsArr: [],
    }));
  };

  formCheck = (e) => {
    e.preventDefault();
  };

  checkAgendaFun = () => {
    this.setState((prevState) => ({
      showAgendaBlock: !prevState.showAgendaBlock,
    }));
  };

  render() {
    return (
      <div>
        <h1 className="mx-5 mb-5">Agenda Manager</h1>
        {!this.state.showAgendaBlock && (
          <div className="container" role="addAgenda">
            <button className="btn btn-info" onClick={this.checkAgendaFun} role="goToView">
              Click To View Agenda
            </button>
            <form onSubmit={this.formCheck}>
              <div className="my-3">
                <label className="form-label">Title</label>
                <input
                  type="text"
                  name="newTitle"
                  placeholder="Enter the title"
                  className="form-control"
                  role="inputTitle"
                  value={this.state.newTitle}
                  onChange={this.changeFun}
                />
                <small className="text-danger" data-testid="invalidTitle">
                  {this.state.newTitle.trim().length === 0 ? "Title is required" : ""}
                </small>
              </div>
              <div className="my-3">
                <label className="form-label">Description</label>
                <input
                  type="text"
                  name="newDescription"
                  placeholder="Enter the description"
                  className="form-control"
                  role="inputDescription"
                  value={this.state.newDescription}
                  onChange={this.changeFun}
                />
                <small className="text-danger" data-testid="invalidDescription">
                  {this.state.newDescription.trim().length === 0 ? "Description is required" : ""}
                </small>
              </div>
              <div className="my-3 w-50">
                <label className="form-label">Enter topic</label>
                <input
                  type="text"
                  name="newTopic"
                  placeholder="Enter the topic"
                  className="form-control"
                  role="inputTopic"
                  value={this.state.newTopic}
                  onChange={this.changeFun}
                />
                <small className="text-danger" data-testid="invalidTopic">
                  {this.state.newTopic.trim().length === 0 && this.state.topicsArr.length === 0
                    ? "Topic is required"
                    : ""}
                </small>
              </div>
              <button
                className="btn btn-success addAlign"
                role="addTopicBtn"
                onClick={this.topicFun}
                disabled={this.state.newTopic.trim().length === 0}
              >
                + Add Topic
              </button>
              <button
                className="btn btn-success submitAlign"
                role="submitAgendaBtn"
                onClick={this.agendaFun}
                disabled={
                  this.state.newTitle.trim().length === 0 ||
                  this.state.newDescription.trim().length === 0 ||
                  this.state.topicsArr.length === 0
                }
              >
                Submit Agenda
              </button>
            </form>
            {this.state.topicsArr.length === 0 && (
              <div className="text-danger ml-2 mt-5" data-testid="noTopicsMsg">
                No Topics Added
              </div>
            )}
            {this.state.topicsArr.length > 0 && (
              <div className="card my-3">
                <div className="card-header">Added Topics</div>
                <div className="card-body">
                  <ul className="list-group">
                    {this.state.topicsArr.map((topic, index) => (
                      <li className="list-group-item" role="topicList" key={index}>
                        {topic}
                      </li>
                    ))}
                  </ul>
                </div>
                <div className="card-footer">Refer to the topics you added</div>
              </div>
            )}
          </div>
        )}
        {this.state.showAgendaBlock && (
          <div className="container" role="viewAgenda">
            <button className="btn btn-info" role="goToAdd" onClick={this.checkAgendaFun}>
              Click To Add Agenda
            </button>
            {this.state.AddedAgenda.map((agenda, index) => (
              <div className="card my-3" role="cards" key={index}>
                <div className="card-header">{agenda.title}</div>
                <div className="card-body">
                  <ul className="list-group">
                    {agenda.topics.map((topic, idx) => (
                      <li className="list-group-item" key={idx}>
                        {topic}
                      </li>
                    ))}
                  </ul>
                </div>
                <div className="card-footer">{agenda.description}</div>
              </div>
            ))}
          </div>
        )}
      </div>
    );
  }
}

export default App;

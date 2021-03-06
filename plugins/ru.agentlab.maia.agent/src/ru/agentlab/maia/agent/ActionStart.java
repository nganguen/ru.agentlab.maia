package ru.agentlab.maia.agent;

import ru.agentlab.maia.AgentState;

final class ActionStart extends Action {

	private static final long serialVersionUID = 1L;

	ActionStart(Agent agent) {
		super(agent);
	}

	@Override
	protected void compute() {
		try {
			agent.setState(AgentState.ACTIVE);
			agent.roleBase.activateAll();
			agent.executor.submit(new ActionExecute(agent));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
package ru.agentlab.maia.context.e4.test

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.e4.E4MaiaContext

import static org.mockito.Mockito.*
import ru.agentlab.maia.context.test.ContextSetByClassAbstractTests

@RunWith(MockitoJUnitRunner)
class E4ContextSetByClassTests extends ContextSetByClassAbstractTests {

	@Accessors
	IMaiaContext context = spy(new E4MaiaContext(EclipseContextFactory.create))

}
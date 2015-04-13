package ru.agentlab.maia.container

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService

/**
 * Factory for creating Container contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ContainerFactory implements IContainerFactory {

	val static LOGGER = LoggerFactory.getLogger(ContainerFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextServiceManagementService contextServiceManagementService

	@Inject
	MaiaContainerProfile containerProfile

	@Create
	override createContainer(IMaiaContext parentContext) {
		val context = if (parentContext != null) {
				parentContext
			} else {
				this.context
			}
		LOGGER.info("Try to create new Default Container...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Create Container Name...")
		val namingService = contextServiceManagementService.createService(containerProfile, parentContext,
			IMaiaContextNameFactory)
		if (namingService == null) {
			throw new IllegalStateException("Agent Profile have no required IMaiaContextNameFactory")
		}
		val name = namingService.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create Container Context...")
		val containerContext = contextFactory.createChild(context, "Context for Container: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
		]

		LOGGER.info("Create Container specific services...")
		contextServiceManagementService => [ manager |
			containerProfile.implementationKeySet.forEach [
				manager.createService(containerProfile, containerContext, it)
			]
			containerProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(containerProfile, context, containerContext, it)
			]
		]
		LOGGER.info("Container successfully created!")
		return containerContext
	}

}